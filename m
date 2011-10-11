Return-Path: <cyrus@holtmann.org>
Subject: Re: Question about A2DP, Pulseaudio.
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 11 Oct 2011 11:37:01 +0530
In-Reply-To: <1318234286.16562.8.camel@chanten-desktop>
References: <1318234286.16562.8.camel@chanten-desktop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318313229.11749.22.camel@snowflake>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2011-10-10 at 17:11 +0900, Chan-yeol Park wrote:
> Hello bluetooth developers.
> 
> I have a few questions about BlueZ,PulseAudio.
> If there are any plan to develop. I want to discuss how to implement the
> below.
> 
> 1. How to handle New Codec(A2DP) between BlueZ and PulseAudio
> As far as I understand puleaduio add_card() working by UUID info.
> however , in case of mpeg and other codec, we can't use it.

JFYI, I have a branch that does switching between PCM-MPEG using the old
Unix sockets API at:

http://cgit.collabora.com/git/user/arun/pulseaudio.git/log/?h=passthrough

There's a bug w.r.t. applying the correct sample rate (44.1 kHz works
fine, 48 kHz audio seems to be playing at 44.1 kHz).

Cheers,
Arun

