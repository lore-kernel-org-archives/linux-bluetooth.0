Return-Path: <cyrus@holtmann.org>
Subject: Re: [GSoC'10] : New Command Line Tool(s) for bluez
From: Bastien Nocera <hadess@hadess.net>
To: Alexander Orlenko <zxteam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
References: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 20 May 2010 14:08:38 +0100
Message-ID: <1274360918.27274.3302.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-05-21 at 00:04 +1100, Alexander Orlenko wrote:
> Hi everyone,
> 
> My name is Alexander Orlenko, I am a GSoC student of this year. I am
> doing a project "bluez-tools",
> http://hostisdown.org/gsoc/projects/bluez-tools (a little more info
> about the project). I need some feedback about what approach should I
> take.

I'm not sure whether you'd be interested, but you could base your code
on the non-GTK parts of libgnome-bluetooth, which already implements a
number of those things, and would just need to be wrapped up.

Cheers

