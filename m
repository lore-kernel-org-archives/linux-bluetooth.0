Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwj_TFTHVmibtSto8Fd3hVFPkkW8ZLhuL_5NopRbopBD=A@mail.gmail.com>
References: <1367532265-26766-1-git-send-email-deymo@chromium.org>
	<CABBYNZJ5=gLRTdD=Ggi3VN62tM4E77BTw3G6FszcLqXjtV-Jqg@mail.gmail.com>
	<CAGd9gwj_TFTHVmibtSto8Fd3hVFPkkW8ZLhuL_5NopRbopBD=A@mail.gmail.com>
Date: Sun, 5 May 2013 12:06:09 +0300
Message-ID: <CABBYNZ+iyquChaiKHK92+G7KM0MF3fned16Y4DAZvq21drNREw@mail.gmail.com>
Subject: Re: [PATCH] audio: Don't create an avctp session on avrcp disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"keybuk@chromium.org" <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, May 3, 2013 at 9:39 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hi!
> I'm far from an expert in the audio profile code (that's why I had to
> include such amount of debug traces =] ).
> Both patches are ok with me, I just find my approach a bit more robust since
> the next inclusion an avrcp_disconnect() will also need to check if the
> avctp is disconnected or not.
> Anyway, I just tried yours on my system and it works for me.
> Thanks for the patch!

Patch is now upstream including some cleanups and other fixes to
problems I discovered while testing, let us know if you find anything
else has been broken.

We will probably do some changes to profiles/audio/device.c, right now
the only thing that it should be doing is auto connecting AVRCP if
A2DP connects, so Im cleaning up it quite a bit. In future we might be
able to completely remove it and perhaps have the core or a dedicated
plugin handling profile dependencies such as AVRCP/A2DP using the
service infrastructure, but service is not very stable right now so we
first need to fix it first before converting the rest to use the
service states.

Btw, please respond inline, top posting is not recommended as stated
http://www.bluez.org/development/lists/

--
Luiz Augusto von Dentz
