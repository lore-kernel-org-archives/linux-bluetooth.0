Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Create an AVDTP signaling channel
Date: Wed, 17 Sep 2014 09:33:11 +0200
Message-ID: <3004548.VX6QZ5TmgY@leonov>
In-Reply-To: <CACUGKYPaqcyKxv9zmiRraDsV1=ErsTCP5rUqguEdh6aEZshZKA@mail.gmail.com>
References: <CACUGKYPaqcyKxv9zmiRraDsV1=ErsTCP5rUqguEdh6aEZshZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tuesday 16 of September 2014 17:04:46 John Tobias wrote:
> Hello All,
> 
> I am using Bluez 5.23 and running PTS 5.2. I am trying to test the
> AVDTP profile and the PTS software prompt me a dialog box "Create an
> AVDTP signaling channel" (please see the attached image.
> 
> I would like to know how to make response via bluetoothctl or any
> command line to continue PTS testing?.

Connecting A2DP profile (AVDTP is a protocol used by A2DP) should do that (for 
that you would also need PulseAudio 5). So if you have all set up 'connect 
<pts_bdaddr>' should do.

Other option would be to use android/avdtptest tool for AVDTP protocol 
testing. But this would test android/avdtp-lib and not the AVDTP code used in 
Linux daemon (those will be unified, eventually).

-- 
BR
Szymon Janc
