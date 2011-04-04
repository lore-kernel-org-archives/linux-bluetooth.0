Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikpv9_MgFtHmxAb_zzmCQVX78HQ+Q@mail.gmail.com>
References: <BANLkTikpv9_MgFtHmxAb_zzmCQVX78HQ+Q@mail.gmail.com>
Date: Mon, 4 Apr 2011 12:02:26 +0300
Message-ID: <BANLkTi=YSMeNpFoi8mwHz-8SjiQOPu6G5g@mail.gmail.com>
Subject: Re: [GSoC] about "Improve A2DP support"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vincent Medivh <medivhc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 4, 2011 at 4:24 AM, Vincent Medivh <medivhc@gmail.com> wrote:
> Hi
>
> I am interested in the idea "Improve A2DP support". I  knew a little
> knowledge of Bluetooth. After some "googling", I still have some
> confusion about "Improve support for Sink role and coexistence with
> HFP gateway role. " Does it mean while I am using the Bluetooth kit as
> the speaker of some mp3 player, still I can use the kit to make a
> phone call via Bluetooth HFP?
>
> I also have a question that I now have a USB Bluetooth dongle, a iPod
> touch and a cellphone(Nokia 6120c), are  those things enough to build
> the test environment?

You will probably need a pc running linux, but I guess you already
figured that out don't you?

> I have a little experience of Linux multimedia programming (a mp3
> player program on ARM development board). I am good at C and have some
> experience of hacking Linux kernel. I think I am also a fast learner.
> Am I qualified to the Google Summer of Code project?

Yes, but you do have understand that you are qualified to apply to
project which doesn't mean you will get one for sure.

> Recently I am reading the the code of the BlueZ and the Bluetooth
> specification, but I still don't get the full understanding of the
> structure of BlueZ. Could someone guide me about which I should focus
> on to implement the idea?  I am also writing the proposal,but have no
> ideas about the project milestones. I will be grateful if someone
> could give some suggestions.

A good start is, audio/a2dp.c and audio/avdtp.c and take a look at
a2dp and avdtp specs on bluetooth.org.

> Here is more information about me, the answers to the questions.
>
> https://docs.google.com/document/d/1HmDybIBT9GMNaByLy8EpW0RwzLcMtyrHuCPA54NHl5I/edit?hl=en
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer
