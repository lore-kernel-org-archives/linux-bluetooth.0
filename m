Return-Path: <cyrus@holtmann.org>
Message-ID: <1E0C6F4C3D9940BA8E8D3BA2FC16B573@alexm>
From: "Alex Mach" <alexvm12e@mail.ru>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru> <CABBYNZJzJPf1KYVpDJvr_UO722DTYzRV0vG6X7OnUHZVK8aq_A@mail.gmail.com>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
Date: Wed, 21 Sep 2011 16:13:40 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

the string in the header seems ok (file name is 1087.mid):

> ACL data: handle 42 flags 0x02 dlen 70
    L2CAP(d): cid 0x0040 len 66 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 61 fcs 0xd2 credits 1
        OBEX: Put cmd(c): len 61
        Name (0x01) = Unicode length 18
        0000: 00 31 00 30 00 38 00 37  00 2e 00 6d 00 69 00 64 
.1.0.8.7...m.i.d
        0010: 00 00 
..
        Length (0xc3) = 6718
        Type (0x42) = Sequence length 11
        0000: 61 75 64 69 6f 2f 6d 69  64 69 00 
audio/midi.
        Time (0x44) = Sequence length 15
        0000: 32 30 31 31 30 39 30 33  54 31 33 32 36 34 38 
20110903T132648

>> I have a problem with receiving files with obexd. After it receives 
>> header
>> it hangs up the connection with
>> obex_handle_input: poll event HUP ERR
>
>> bluez-4.95
>> kernel-2.6.38.7 armv5tejl GNU/Linux
>> libopenobex1-1.5
>> obexd-0.42
>>
>> /usr/sbin/obexd --auto-accept --root=/var/obex
>>
>> obexd[844]: src/obex.c:check_put() OBEX_HDR_NAME: (null)

> Problem seems to be here, apparently we could not convert the name
> received (Unicode length 18 according to hcidump), so the name is not
> set cause plugin/ftp.c:268 to fail. Could you please check what is the
> string in the header and if that is really a utf16 as the spec
> mandates.

> -- 
> Luiz Augusto von Dentz

Thanks,
Alex. 

