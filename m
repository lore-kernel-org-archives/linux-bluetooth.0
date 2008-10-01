Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Oct 2008 09:26:29 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: David Sainty <david.sainty@dtsp.co.nz>
cc: Mario_Limonciello@Dell.com, hadess@hadess.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
In-Reply-To: <48E2A4D5.8020509@dtsp.co.nz>
Message-ID: <Pine.LNX.4.64.0810010904570.18937@simba.math.ucla.edu>
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
  <1222679240.1825.14.camel@violet.holtmann.net>  <1222679724.3311.53.camel@cookie.hadess.net>
  <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
 <1222701730.3311.76.camel@cookie.hadess.net>  <48E1DCA8.2040005@dtsp.co.nz>
 <1222762649.1825.56.camel@violet.holtmann.net> <48E1E9D3.8050202@dtsp.co.nz>
 <FA7963CC89065B49AED46A6F797F0FA6F2869C@AUSX3MPC128.aus.amer.dell.com>
 <48E2A4D5.8020509@dtsp.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 1 Oct 2008, David Sainty wrote:

> xdpyinfo says the DPI is 100x101... heh...
> 
>  dimensions:    800x480 pixels (203x121 millimeters)
>  resolution:    100x101 dots per inch
> 
> In reality it's around 133dpi (153mm x 92mm).

I'm sure the erratic sizing comes from nonuniform font selection.

I had endless trouble printing web pages from a Dell Inspiron 6400 
(1680x1050px, 128dpi if I remember right, Opera browser) and a Nokia N810 
(800x480px, 226dpi, Mozilla clonoid for GTK) -- the text glyphs were way 
oversize, even overlapping.  To fix, I lied to my X-server claiming 96dpi. 
As I understand it, one of the libraries scales the PostScript font, but 
not the graphical content, so the glyphs are the same size as those on the 
physical screen, which of course is a crock on the N810, or on an Eee, and 
is also a poor strategy on the laptop.

My current opinion is that all the apps should specify a font of Serif or 
Sans-Serif (according to the theme), and the user (with the help of good 
defaults in the distro) should set the default font size so he can read 
them with his eyes (blurred with age) and physical screen, and the apps 
should never override that setting, at most making small relative changes 
for titles or fine print notes.  Erratic font sizes are one objection I 
have to Maemo on the N810, but Maemo is definitely not the only offender.

I wonder if the Bluetooth applet follows this rule?  Judging from the 
discussion, most likely it does, and it's then at the mercy of the distro's 
setup.

Judging the screenshots that were shown, I think the landscape layout (new) 
is more practical for the N810.  However, the smallest screen I have to 
deal with at work is the Palm Treo 650 at 320x320px.  It wouldn't be 
running Linux, but if it were, both orientations would be equally bad.  I 
suspect that handheld devices are the most likely to have Bluetooth 
accessories, since they have the most limitation in power and USB ports, so 
special effort should be put in to fit any dialog boxes reliably on the 
small screens, assuming the distro provides defaults that make this 
possible.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
