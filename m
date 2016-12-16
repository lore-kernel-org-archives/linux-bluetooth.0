Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Dec 2016 14:34:03 +0200
Message-ID: <CABBYNZKbuSLNMFVGzscK_faPEdHT-tH1=g48sdcyM6fhYHm5CA@mail.gmail.com>
Subject: Re: Bluetooth 6lowpan ping6 slab corruption
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Cc: "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

On Fri, Dec 16, 2016 at 8:46 AM, Wong, Joshua Weng Onn
<joshua.weng.onn.wong@intel.com> wrote:
> $ ifconfig (look for bt0 interface) << to obtain IPv6 address of slave device

This is not right, the address of bt0 is in fact the local address not
the remote address, not sure if that could cause the problems bellow
though.

> $ ping6 -I bt0 <IPV6_ADDR>     <<<<------ The console message starts to appear here during ping6
>
> The output of the console message:
>
> [  794.985623] Slab corruption (Tainted: G     U         ): skbuff_head_cache start=ffff8801f568f700, len=232
> [  795.008755] 050: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  ....kkkkkkkkkkkk
> [  795.029380] Prev obj: start=ffff8801f568f600, len=232
> [  795.044743] 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  795.061310] 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  795.076752] Next obj: start=ffff8801f568f800, len=232
> [  795.088448] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [  795.102365] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>
> The 6lowpan connection between the two devices is connected.
> I observed that the console message appears once when the master initiates the connection to the slave and nothing happens after that.
> Once I start doing the ping6 from master to slave, the same message appears again. This same set of message continues to be printed every 5 seconds or so.
> This also persists when ping6 is done from the slave to the master.
>
> Do you know what could possibly cause this issue?
>
> Please let me know if you require further information.
>
> Thank you.
>
> Best regards,
> Joshua
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
