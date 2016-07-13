Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: bluez 5.40 - RegisterApplication as Client
Date: Wed, 13 Jul 2016 10:45:06 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D744B32@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D743728@S0MSMAIL111.arc.local>,<cd0204e760b642a1bfb1f25586ed87be@FE-MBX1011.de.bosch.com>
 <E92610C73D6DE84EB154DC52F5ECCE541D743784@S0MSMAIL111.arc.local>
 <dfc116e86d434a64808bf7e5aafd37b0@FE-MBX1011.de.bosch.com>
In-Reply-To: <dfc116e86d434a64808bf7e5aafd37b0@FE-MBX1011.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

-- snip
 -- snap
> 
> > >/org/bluez/hcix
> > >Use org.bluez.Adapter1 for scanning, scan filters and to power up.
> > >--> Interact with the adapter  --> adapter-api.txt Use
> > >org.bluez.GattManager1 to autoconnect (RegisterProfile API... do not
> > >use RegisterApplication here) --> >gatt-api.txt
> >
> > I have successfully used the RegisterProfile API with previous
> > versions of bluetoothd, but in version 5.40 the RegisterProfile method
> > does not exist anymore at the GattManager object, instead
> > doc/gatt-api.txt says
> >
> > "void RegisterApplication(object application, dict options)
> >
> > 			Registers a local GATT services hierarchy as described
> > 			above (GATT Server) and/or GATT profiles (GATT
> Client).
> >
> > 			The application object path together with the D-Bus
> > 			system bus connection ID define the identification of
> > 			the application registering a GATT based
> > 			service or profile."
> > In this sense I have seen my application as a client and registered
> > the application with a list of GATT profiles. Is this correct?
> 
> Ah OK, I'm sorry, I'm still used to 5.38 and thus missed the 5.40 change with
> respect to the RegisterApplication part.
> You understood correctly to use this one to replace the old RegisterProfile API. I
> checked gatt-database.c and it seems to be implemented as expected:
> The proxies to all org.bluez.GattProfile1 interfaces are added to the database.
> Each profile is set to autoconnect. Devices with matching profiles are also set
> to autoconnect.
> 
> We seem to have another problem here. Could you try to explain in more detail
> what goes wrong?
> 1. What do you expect to happen?
> 2. What happens?

1. I expect that when I register an Application as a client with GattProfile1 objects and lists of services that bluetoothd accepts connections only form devices providing this profiles/services.
That makes sense since otherwise data are sent but not handled by an application and therefor the data get lost.

2. What happens is that as soon as I register my Application with an arbitrary GattProfile1 all connections from paired devices are accepted. E.g.  I registered a Weight Scale service but also a connection from a blood pressure device gets accepted even no service is registerted and no application is existing which is able to handle this data.
 
Does that make it more clear



> From what I understood registering profiles will make bluez auto-connect to
> devices with registered profiles. Your question below indicates you're expecting
> something else (talking about accepting/blocking data?)
> 
> > Regards,
> > Johannes
> 
> >
> > > -----Original Message-----
> > > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > > owner@vger.kernel.org] On Behalf Of Kropf Johannes
> > > Sent: Friday, July 08, 2016 1:45 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Subject: bluez 5.40 - RegisterApplication as Client
> > >
> > > Hi,
> > >
> > > I have registered an application as a Gatt client using the
> > > GattManager1 interface with an ObjectManager providing the profiles
> > > as implementations of the
> > > GattProfile1 interface.
> > >
> > > As soon as I register one profile, any other profile gets accepted
> > > as well, e.g. I registered a blood pressure profile with the
> > > supported services, but bluetoothd is also accepting data from a
> > > weight scale device without having its service registered on the application
> side.
> > >
> > > Is this a bug?
> > >
> > > Kind regards,
> > > Johannes
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-bluetooth" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
