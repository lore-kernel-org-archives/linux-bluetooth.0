Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Two simultanous connections
Message-Id: <20040403182438.6f0cc196.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <1080997306.12501.10.camel@localhost>
References: <1080928843.9541.90.camel@localhost>
	<1080929429.2836.101.camel@pegasus>
	<1080993011.12261.12.camel@localhost>
	<1080994581.2839.26.camel@pegasus>
	<1080997306.12501.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 3 Apr 2004 18:24:38 +0200

On Sat, 03 Apr 2004 15:01:46 +0200
Pierre N <pierren@mac.com> wrote:

> On Sat, 2004-04-03 at 14:16, Marcel Holtmann wrote:
> > Hi Pierre,
> > 
> > > hcitool -a shows "invalid option -- a".
> > 
> > who said that hcitool have an "-a" option.
> 
> Sorry, I mixed up hcitool and hciconfig...
> 
> > Actually I don't see your problem. Let one iPAQ be the master and the
> > other connect as slaves.
> 
> Who said I had a problem? ;-p
> This is all, as I said previously, out of curiosity...
> 
> Seriously, my question is why can a master hold up to 4 slaves but can't
> initiate these 4 connections itself as a master?
> 
> Is it technically impossible, is it just an implementation constraint or
> is there some secret switch to do so?
> 

check the role-switch procedure, its done with "hcitool" and its opention "sr". 
Both Sides have to support this feature.

Greetings

Andy



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
