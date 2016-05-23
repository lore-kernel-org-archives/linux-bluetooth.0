Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5742D40A.4080903@gmail.com>
References: <5742D40A.4080903@gmail.com>
Date: Mon, 23 May 2016 15:24:39 +0300
Message-ID: <CABBYNZKVgGZ-3d_GEEDWmYxsvtPyncnF0xb3pxFP8ZpuCO0aag@mail.gmail.com>
Subject: Re: gatt client clones break indication/confirmation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikhail Krivtsov <mikhail.krivtsov@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikhail,

On Mon, May 23, 2016 at 12:57 PM, Mikhail Krivtsov
<mikhail.krivtsov@gmail.com> wrote:
> When bt_gatt_client receives 'indication' it sends 'confirmation'.
> 'confirmation' sending was broken after adding support for 'clones' of
> bt_gatt_client. In addition to first bt_gatt_client each clone also
> sends 'confirmation'.
>
> # > ACL Data RX: Handle 69 flags 0x02 dlen 27
> #       ATT: Handle Value Indication (0x1d) len 22
> #         Handle: 0x001f
> #           Data: 68656c6c6f2027302e302e302e303a3532353332
> # < ACL Data TX: Handle 69 flags 0x00 dlen 5
> #       ATT: Handle Value Confirmation (0x1e) len 0
> # < ACL Data TX: Handle 69 flags 0x00 dlen 5
> #       ATT: Handle Value Confirmation (0x1e) len 0
>
> Extra confirmation sent by clone confuses remote side. When bluetooth
> daemon receives extra confirmation it breaks connection.
>
> Attached patch fixes the issue limiting confirmation sending to single
> bt_gatt_client.

I went ahead and applied this fix, thanks for the contribution.

*Next time please do follow the instruction under HACKING and send as
a proper patch.


-- 
Luiz Augusto von Dentz
