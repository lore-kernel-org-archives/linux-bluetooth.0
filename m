Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <367108.65360.qm@web52604.mail.re2.yahoo.com>
References: <367108.65360.qm@web52604.mail.re2.yahoo.com>
Date: Fri, 26 Feb 2010 10:41:56 +0200
Message-ID: <2d5a2c101002260041n472b3d23m10f9048f69ea1b23@mail.gmail.com>
Subject: Re: obexd 0.14 "put" file corruption
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 25, 2010 at 12:23 AM, Ed Tsang <netdesign_98@yahoo.com> wrote:
>
>
>>I am using obexd 0.14 to push files into phone. The image file received by some phone seem a bit strange and in some phone it could not be >display at all. So I tried a simple text file with line number as text. Then I saw the file received from the phone is corrupted. Looking into the >hcidump look like the second "Put cmd" and forward, the first "0xc8" bytes was not copied (stay the same as the firs put cmd).
>>  Anyone know if this is a known problem in 0.14 or fixed in the latest (obexd 0.20).
>  Installed the obexd o.20. Same problem???
> -------------------------- first put
>     RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 303 fcs 0x4f
>        OBEX: Put cmd(c): len 3922
>        Name (0x01) = Unicode length 12
>        0000: 00 74 00 2e 00 74 00 78  00 74 00 00              .t...t.x.t..
>        Length (0xc3) = 8208
>        Body (0x48) = Sequence length 3896
>        0000: 30 30 20 66 69 72 73 74  20 6c 69 6e 65 20 20 0a  00 first line  .
>        0010: 31 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  1              .
>
> ...................... second put  (after 0xc8 is fine)
>      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 283 fcs 0x4f
>        OBEX: Put cmd(c): len 3902 (continue)
>        Body (0x48) = Sequence length 3896
>        0000: 30 30 20 66 69 72 73 74  20 6c 69 6e 65 20 20 0a  00 first line  .
>        0010: 31 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  1              .
>        0020: 32 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  2              .
>        0030: 33 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  3              .
>        0040: 34 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  4              .
>        0050: 35 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  5              .
>        0060: 36 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  6              .
>        0070: 37 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  7              .
>        0080: 38 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  8              .
>        0090: 39 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  9              .
>        00a0: 41 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  A              .
>        00b0: 42 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  B              .
>        00c0: 43 20 20 20 20 20 20 20  31 30 30 20 73 65 63 6f  C       100 seco
>        00d0: 6e 64 20 70 61 67 65 0a  31 20 20 20 20 20 20 20  nd page.1
>        00e0: 20 20 20 20 20 20 32 0a  32 20 20 20 20 20 20 20        2.2
>
> Anyone bump into this?? look like the start of copying problem...

Weird, are you sure the client is sending this properly? Anyway we do
store the data in a buffer even if was sent together with put cmd, Im
very suspicious that this is not the problem since we would have
notice this before. Btw obexd does not push/send files obex-client
does, are you talking about obex-client?

-- 
Luiz Augusto von Dentz
Computer Engineer
