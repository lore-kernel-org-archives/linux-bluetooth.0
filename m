Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 11 May 2015 11:12:18 +0300
Message-ID: <CABBYNZK216huJmzBL0K0wMmLH3F_QS1iKmc-vdo4ABLtTRVZaA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add decoding of BNEP control msg packet types
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, May 7, 2015 at 1:22 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Decodes below BNEP control msg pkt:
> 1) Commad Not Understood Msg
> 2) Setup Connection Req Msg
> 3) Filter NetType Set Msg
> 4) Filter MultiAddr Set Msg
> 5) Common Rsp msg for above requests.
>
> And also handles the BNEP extension header packet.
>
> Gowtham Anandha Babu (6):
>   monitor: Add decoding of Cmd Not Understood pkt
>   monitor: Add decoding of Setup Conn Req pkt
>   monitor: Add decoding of Filter NetType Set pkt
>   monitor: Add decoding of Filter MultAddr Set pkt
>   monitor: Add decoding of common rsp msg pkt
>   monitor: Add decoding of BNEP Extension Header pkt
>
>  monitor/bnep.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 216 insertions(+), 9 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
