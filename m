Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: bluez 5.40 - RegisterApplication as Client
Date: Fri, 8 Jul 2016 15:53:36 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D743784@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D743728@S0MSMAIL111.arc.local>,<cd0204e760b642a1bfb1f25586ed87be@FE-MBX1011.de.bosch.com>
In-Reply-To: <cd0204e760b642a1bfb1f25586ed87be@FE-MBX1011.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

thanks for your extensive explanations. Indeed there where some confusions during the discussion so far, and I'm still not 100% certain about it, but it got much clearer already. 

>Hi Johannes,
>
>I'm not sure, but I think you accidently mixed up something and thus got misleading answers.
>If you want to run a peripheral, you add a GATT hierarchy as described at doc/gatt-api.txt to the dbus. Then you >call bluez RegisterApplication to tell bluez to have a look at it and to setup a services. This method is available via >the org.bluez.GattManager1 interface provided by the org.bluez Service. Other steps include powering up your >device and advertising this service via the according org.bluez interfaces and methods.

>But if I understood correctly you do not want to setup a peripheral, but a central. In this case you do not need the >RegisterApplication call.
>As a client you want to scan, to connect, and to use the Services and Characteristics provided by the remote >devices.
Yes, that is what I want to do!

>/org/bluez/hcix
>Use org.bluez.Adapter1 for scanning, scan filters and to power up. --> Interact with the adapter  --> adapter-api.txt
>Use org.bluez.GattManager1 to autoconnect (RegisterProfile API... do not use RegisterApplication here) --> >gatt-api.txt

I have successfully used the RegisterProfile API with previous versions of bluetoothd, but in version 5.40 the RegisterProfile method  does not exist anymore at the GattManager object, instead doc/gatt-api.txt says 

"void RegisterApplication(object application, dict options)

			Registers a local GATT services hierarchy as described
			above (GATT Server) and/or GATT profiles (GATT Client).

			The application object path together with the D-Bus
			system bus connection ID define the identification of
			the application registering a GATT based
			service or profile."
In this sense I have seen my application as a client and registered the application with a list of GATT profiles. Is this correct?


>/org/bluez/hcix/dev_12_23_34_34_35_53 (devices will show up after scanning)
>Use org.bluez:Device1 to interact with the remote device: Connect/Disconnect, Pair, ConnectProfile, Name, >UUIDs, RSSI, ... -->device-api.txt
Yes, I can scan, pair and read parameters of the devices within my application

>Below the devices you'll find full service hierarchies --> gatt-api.txt
>You can discover and browse them by using the ObjectManager API and Signals.
Clear for me, thanks.

>For example:
>/org/bluez/hcix/dev_12_23_34_34_35_53/Service0002
>Use the org.bluez.GattService1 API to check out the service UUID of the service that can be found at this object >path.

>I recommend using d-feet and just browse and click on the dbus to get startet as a client. Once you got a feeling >for the API by using manual calls, go on implementing whatever you need. This d-feet also helps checking if the >API is still what you expect it to be (not running the bluetoothd version you expected) or if the -E flag on >bluetoothd got lost.
Indeed, I extensively used d-feet to get a feeling how everything works and to see which objects exist and which methods they provide. 

>Cheers,
>Markus

Regards,
Johannes

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Kropf Johannes
> Sent: Friday, July 08, 2016 1:45 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: bluez 5.40 - RegisterApplication as Client
>
> Hi,
>
> I have registered an application as a Gatt client using the GattManager1 interface
> with an ObjectManager providing the profiles as implementations of the
> GattProfile1 interface.
>
> As soon as I register one profile, any other profile gets accepted as well, e.g. I
> registered a blood pressure profile with the supported services, but bluetoothd is
> also accepting data from a weight scale device without having its service
> registered on the application side.
>
> Is this a bug?
>
> Kind regards,
> Johannes
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
