Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6E8CB7.7060304@dtsp.co.nz>
Date: Tue, 28 Jul 2009 17:29:27 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Gnome applet failing with current BlueZ?
References: <4A6E3161.7010105@dtsp.co.nz>	 <1248742400.23466.11069.camel@localhost.localdomain>	 <4A6E523E.6000802@dtsp.co.nz> <1248744238.23466.11103.camel@localhost.localdomain> <4A6E5B7F.4000109@dtsp.co.nz> <4A6E7FD8.5090908@dtsp.co.nz>
In-Reply-To: <4A6E7FD8.5090908@dtsp.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

David Sainty wrote:
> I've tried rolling back BlueZ as far back as 4.26, and gnome-bluetooth 
> back to 2.27.6, but no change.  I guess the problem is related to some 
> other update - maybe something to do with fallout from the dbus 
> "permissive" security issue (I'm using dbus-1.2.4.2permissive at the 
> moment).
>
> I guess I'll need to track it down myself...  Any helpful advice on 
> where I should look is most welcome though :)

Damn!  bluetooth-applet has magically started working after reinstalling 
2.27.8 and 4.26 (and various restarts of, E.g. dbus, hald).  That's just 
mysterious.  Well... never mind.

