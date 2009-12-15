Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000401ca7dc9$550a3030$ff1e9090$@uni-marburg.de>
References: <1260899794-5107-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <000401ca7dc9$550a3030$ff1e9090$@uni-marburg.de>
Date: Tue, 15 Dec 2009 19:52:06 -0200
Message-ID: <6b53b1990912151352p1563da87h15b95b5d258e7dd0@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: fix unset of RemoteBusy flag
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marian Harbach <harbach@mathematik.uni-marburg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marian,

On Tue, Dec 15, 2009 at 6:58 PM, Marian Harbach
<harbach@mathematik.uni-marburg.de> wrote:
> Hi,
>
> I have the same problem as described in this post:

No, you don't have. This patch is about L2CAP Enhanced Retransmission
Mode and it's not related to the problem you had.

>
> http://www.spinics.net/lists/linux-bluetooth/msg03627.html
>
> I found that depending on filesize, the original input is delayed by some
> bytes (180-260 for 16kHz PCM input) and additionally the first few samples
> are overwritten when doing sbcenc followed by sbcdec.
>
> Is there a fix for this issue?
>
> Cheers
> Marian
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan
http://padovan.org
