Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluez/android
Date: Mon, 15 Jun 2015 18:23:12 +0200
Message-ID: <7472174.apJaRDVe8G@athlon>
In-Reply-To: <CAKafyqoqW9H1d0FBGFJGsbwSqAVpNAAYG8pHPEAUTLOXYRWwnw@mail.gmail.com>
References: <CAKafyqq_RN9syQgA3o8z0Wx_DN8O83i4A2S5Ns8N4-SWNyE4Mg@mail.gmail.com> <2870599.ZBzDzverey@leonov> <CAKafyqoqW9H1d0FBGFJGsbwSqAVpNAAYG8pHPEAUTLOXYRWwnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Monday 15 June 2015 20:29:25 Prabhu Chawandi wrote:
> Hi Szymon,
> 
>  Sorry for posting with ML, my mistake.

Yet, you still top post.

> 
> Thanks for the information.  Again, I was trying to find where the
> unknown AT Commands are coming;
> I tried to catch @ static void at_cmd_unknown(const char *command,
> void *user_data);
> But, no luck, no AT commands are caught there.  If you can let me
> know, where all the AT commands will be handled would be of great help
> ( unknown - so that I can handle then)

Please check "android/hardware/bt_hf.h". Most commands that are not handled 
internally by BfA have dedicated callbacks. unknown_cmd callback is mostly for 
vendor specific commands and you can safely always just answer with ERROR for 
unknown command.
 
> ManYThanks
> Prabhu
> 
> On Mon, Jun 15, 2015 at 7:45 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Hi Prabhu,
> > 
> > On Monday 15 of June 2015 19:11:32 Prabhu Chawandi wrote:
> >> Hi Szymon,
> >> 
> >>    Thanks for your reply. I was debugging further, I noticed that
> >> 
> >> while connecting at service level, there is CIND callback
> >> (cind_cmd_cb) is coming which is for Call Indicator AT CMD.
> >> I am curious to know, how it is happening, which can help me to
> >> understand and  try for other call backs.
> > 
> > Please don't top-post on ML.
> > 
> > As for your question: HFP HAL has methods that should be called as a reply
> > for some callbacks ie for cind that would be cind_response. You can check
> > "android/hardware/bt_hf.h".
> > 
> > Yet, Android HAL is rather lowlevel interface not recommended for direct
> > use. If for whatever reason you are stuck with it I suggest checking
> > Android Framework source code as this (and header comments) is the only
> > documentation you get for it.
> > 
> >> On Mon, Jun 15, 2015 at 5:42 PM, Szymon Janc <szymon.janc@tieto.com> 
wrote:
> >> > Hi Prabhu,
> >> > 
> >> > On Monday 15 of June 2015 17:06:41 Prabhu Chawandi wrote:
> >> >>  This is with respect to HFP profile.
> >> >> 
> >> >> While I pressed the Button on my HF device, service level connection
> >> >> is happening - BTHF_STATE_CONNECTED is coming.
> >> >> 
> >> >> But next callbacks are not coming on pressing of buttons - like voice
> >> >> recognition.
> >> >> 
> >> >> Can any body help me
> >> > 
> >> > HFP is a bit special since BfA provides only part of the implementation
> >> > and
> >> > rest is implemented in Android Framework. When HF device is connected
> >> > SLC
> >> > creation must happen. Most likely your HF device is sending some AT
> >> > commands and you must response to those as per HFP specification. Only
> >> > when all required SLC AT commands are handled state will be set to
> >> > BTHF_STATE_SCL_CONNECTED. This is normally handled by Android Framework
> >> > but if you are using haltest you must handle those on your own.
> >> > 
> >> > For details on how to setup SLC I recommend HFP specification lecture.
> >> > 
> >> > --
> >> > BR
> >> > Szymon Janc
> > 
> > --
> > BR
> > Szymon Janc
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Szymon K. Janc
szymon.janc@gmail.com
