Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103CFCE6@nasanexd01a.na.qualcomm.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
	<1308563100-18917-5-git-send-email-nami.li@atheros.com>
	<BANLkTikwMNxUsv9XeiVnAGJS_2_f-2ugnw@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103CFCE6@nasanexd01a.na.qualcomm.com>
Date: Tue, 21 Jun 2011 09:43:18 +0300
Message-ID: <BANLkTikWV=B5U8EswBqDjOWj-sr2c1k-aA@mail.gmail.com>
Subject: Re: [PATCH obexd 05/14] Server listen on both RFCOMM and L2CAP sockets.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Li, Steven" <yongli@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

On Tue, Jun 21, 2011 at 9:25 AM, Li, Nami <nami@qca.qualcomm.com> wrote:
> Hi, Luiz
>  Thanks for your reply. I understand and agree with your opinion. The "start_l2cap" and "l2cap_confirm_event" functions were written according to "start" and "confirm_event".
> I just keep the parameters passed same with "start" and "confirm_event" functions. I find that "user_data" passed by "start" is also not used in "confirm_event".
> I think keep same parameters is more unified on the structure.
> What do you think ?

I would fix the RFCOMM listen to pass service instead and completely
remove the use of find_service.


-- 
Luiz Augusto von Dentz
