Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] rfcomm shouldn't fail silently
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075135361.25442.57.camel@pegasus>
References: <1075133668.12874.328.camel@saag>
	 <1075135361.25442.57.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075135629.12874.339.camel@saag>
Mime-Version: 1.0
Date: Mon, 26 Jan 2004 16:47:09 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Mon, 2004-01-26 at 16:42, Marcel Holtmann wrote:
> Hi Edd,
> 
> > As reported in this bug
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=229167
> > 
> > rfcomm shouldn't fail silently if an invalid command is given to ie.
> 
> it does not fail silently. It show the the list of bonded devices.

If none are bonded, it is silent :)

The point was there should be a usage error output.

-- Edd
