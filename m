Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] convert sdp browse list to icons`
References: <200412010157.11129.wim.delvaux@adaptiveplanet.com> <1101882358.18840.16.camel@pegasus> <200412011245.29059.wim.delvaux@adaptiveplanet.com>
In-Reply-To: <200412011245.29059.wim.delvaux@adaptiveplanet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412011249.20665.wim.delvaux@adaptiveplanet.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 1 Dec 2004 12:49:20 +0100

On Wednesday 01 December 2004 12:45, wim delvaux wrote:
> On Wednesday 01 December 2004 07:25, Marcel Holtmann wrote:
> > Hi Wim,
> >
> > > Can anybody point me to a document describing how to map an sdp service
> > > entry to the 'class' of a service.
> >
> > as far as I know there exists no mapping for that.
> >
> > > I.e. if the 'text'  field (attribute 0x100) shows 'dialup networking'
> > > then connecting to this service provides just that.  However could this
> > > string be different from device to device ? If so is there a CODE
> > > somewhere in that sdp record that says the same but does not change ?
> >
> > The text field can be freely choosen.
> >
> > > I thing the attribute 0x9 (BluetoothProfileDescriptorList) can be used
> > > for that but it is a LIST meaning multiple values are allowed to there
> > > might be different values in that entry ...
> >
> > You should use the "Service class ID list" (attribute 0x0001) list.
>
>  Is there any table i could refer to to find out which ID maps to which
> feature ?

 And which entry to perfer ? Again this is a list i.e. containing multiple 
items.  So which to choose ?

 W


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
