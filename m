Return-Path: <bb@arbetsmyra.dyndns.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: DBT 120 dongle defaulting to HID mode
Date: Thu, 28 Apr 2005 15:15:45 +0200
References: <pan.2005.04.14.18.57.06.661056@wingnet.net> <pan.2005.04.15.13.26.00.874309@wingnet.net> <1113572820.16433.26.camel@pegasus>
In-Reply-To: <1113572820.16433.26.camel@pegasus>
Cc: Marcel Holtmann <marcel@holtmann.org>
MIME-Version: 1.0
Message-Id: <20050428131624.554B38CB@arbetsmyra.dyndns.org>
List-ID: <bluez-users.lists.sourceforge.net>


> > OK. Has anyone written a program capable of changing arbitrary
> > PS key settings yet? Or do I have to write my own?
>
> there is the pskey program, but this will only work over UART with
> H:4 or BCSP transports. The BlueZ hciconfig code contains code to
> read PS key values, but it can't store them. However I really think
> that we need a graphical pstool for Linux like the CSR one for
> Windows.


Hi
I've been looking for this pskey program, but have yet only found it in 
"iPaq" package format. Anyone with a link to the sources? And has 
anyone used it with other arches than iPaq? If not, does anyone have an 
idea of how much work needs to be done to get it up and running?

Regards
/Ronny Nilsson
