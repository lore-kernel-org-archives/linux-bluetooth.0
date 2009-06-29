Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <434c4b6e0906290635u35d050afkf1397dd50c970eb3@mail.gmail.com>
References: <434c4b6e0906290635u35d050afkf1397dd50c970eb3@mail.gmail.com>
Date: Mon, 29 Jun 2009 13:36:33 -0300
Message-ID: <2d5a2c100906290936j1fc0b614vcf8239707b2a6927@mail.gmail.com>
Subject: Re: Have you ever experienced A2DP trouble with Sony Ericsson HS980
	,970 ?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Chanyeol,Park" <chanyeol.park@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 29, 2009 at 10:35 AM, Chanyeol,Park<chanyeol.park@gmail.com> wrote:
> Hi
>
> Have you ever experienced A2DP trouble with Sony Ericsson HS980 ,970 ?
>
> It takes more time to A2DP setup such as DISCOVER,GET_CAP,SET_CONF…
> including SDP than other devices.
> Their packet is so small and their respond is so late..-.-;
>
> In my case, after I connect its HFP service, their respond is abnormal.
>
> If you know about this problem, could you give a tip or explain this.?

Not really, but you can try sending us the hcidump and bluetoothd logs
so we can take a look. If the device takes too long to respond we may
timeout which could cause us to send ABORT, but without the logs this
just a guess.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
