Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 15:38:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arkadiusz Lichwa <arek.lichwa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Arkadiusz Lichwa <arkadiusz.lichwa@tieto.com>
Subject: Re: [PATCH] lib: Browsing services using sdptool can lead to writing
 to invalid heap locations
Message-ID: <20130404123858.GA11040@x220.ger.corp.intel.com>
References: <1365084573-3195-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365084573-3195-1-git-send-email-arkadiusz.lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

On Thu, Apr 04, 2013, Arkadiusz Lichwa wrote:
> valgrind's output of exemplary call: sdptool browse local
> 
> ==2203== HEAP SUMMARY:
> ==2203==     in use at exit: 0 bytes in 0 blocks
> ==2203==   total heap usage: 251 allocs, 251 frees, 140,156 bytes allocated
> ==2203==
> ==2203== All heap blocks were freed -- no leaks are possible
> ==2203==
> ==2203== ERROR SUMMARY: 6 errors from 2 contexts (suppressed: 0 from 0)
> ==2203==
> ==2203== 1 errors in context 1 of 2:
> ==2203== Invalid write of size 2
> ==2203==    at 0x805B882: bt_put_be16 (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8062BD0: sdp_service_search_attr_req (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8052457: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x80525AE: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x805277F: cmd_browse (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8053199: main (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==  Address 0x4391359 is 7 bytes before a block of size 2,048 alloc'd
> ==2203==    at 0x402B6A8: malloc (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==2203==    by 0x8062B4B: sdp_service_search_attr_req (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8052457: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x80525AE: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x805277F: cmd_browse (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8053199: main (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==
> ==2203==
> ==2203== 5 errors in context 2 of 2:
> ==2203== Invalid write of size 1
> ==2203==    at 0x402D363: memcpy (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==2203==    by 0x80613E7: gen_dataseq_pdu (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8061472: gen_attridseq_pdu (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8062C00: sdp_service_search_attr_req (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8052457: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x80525AE: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x805277F: cmd_browse (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8053199: main (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==  Address 0x439135b is 5 bytes before a block of size 2,048 alloc'd
> ==2203==    at 0x402B6A8: malloc (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==2203==    by 0x8062B4B: sdp_service_search_attr_req (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8052457: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x80525AE: do_search (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x805277F: cmd_browse (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==    by 0x8053199: main (in /home/xpu/gits/bluez.bin/bin/sdptool)
> ==2203==
> ==2203== ERROR SUMMARY: 6 errors from 2 contexts (suppressed: 0 from 0)
> ---
>  lib/sdp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 6c73818..cc685b4 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -4429,6 +4429,11 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
>  
>  	/* add service class IDs for search */
>  	seqlen = gen_searchseq_pdu(pdata, search);
> +	if (seqlen < 0) {
> +		errno = EINVAL;
> +		status = -1;
> +		goto end;
> +	}
>  
>  	SDPDBG("Data seq added : %d\n", seqlen);

The patch looks correct and I've applied it, but could you explain how
exactly you reproduced the issue? I didn't get any valgrind warnings
when trying your suggested "sdptool browse local".

Johan
