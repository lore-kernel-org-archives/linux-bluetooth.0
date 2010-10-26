Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Oct 2010 11:57:04 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: John Crosbie <john@excelfore.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix a2dp play when sample rate changed
Message-ID: <20101026155704.GA14408@jh-x301>
References: <AANLkTikksLAeocFsM5vO0rnvphgOo_CoF1ZA_wkABY=c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikksLAeocFsM5vO0rnvphgOo_CoF1ZA_wkABY=c@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tue, Oct 26, 2010, John Crosbie wrote:
> I have found that playing a 48KHz wav file immediately after playing a
> 44.1K file (or vice-versa) with aplay will fail.  After this failure
> no a2dp stream will play.  The problem is that after determining the
> current avdtp stream doesn't match the new configuration the stream is
> closed and a reconfiguration is attempted but fails because
> setup->rsep is null.  The patch below fixes the reconfiguration.

Thanks for the patch. In the future, please follow the proper coding
style (e.g. space between "if" and "(") and prepare the patches using
git format-patch. I went ahead and did this work manually for you this
time instead of asking you to resend since we're in the process of
preparing the next bluez release.

Johan
