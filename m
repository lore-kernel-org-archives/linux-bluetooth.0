Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Apr 2008 11:23:09 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1208888105.16346.18.camel@greatbear>
Message-ID: <Pine.LNX.4.64.0804221120250.5120@xena.cft.ca.us>
References: <1208888105.16346.18.camel@greatbear>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Telephony plugin framework
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, 22 Apr 2008, Alok wrote:

> 1. 'hcid' maintains a list of 'telephony devices'[a GList]. it also
> exports methods to create, destroy, update these devices.

Sorry, I'm not a regular participant in this thread so I may not be 
understanding something: which devices qualify to be "telephony devices"?  
Only those that announce availability of a HSP service?  Is an A2DP 
headphone forever disqualified (unless it has dual HSP capability which 
some of them do)?

I assume the SDP thread in hcid will take care of registering the 
qualifying devices.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
