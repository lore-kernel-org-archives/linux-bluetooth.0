Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS] open questions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510130606n474e5f9i4c66d99d245a388@mail.gmail.com>
References: <e1effdeb0510130606n474e5f9i4c66d99d245a388@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129210526.6308.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 13 Oct 2005 15:35:26 +0200

Hi Claudio,

> I exchanged some ideas with Johan Hedberg yesterday and I would like
> receive feedbacks from bluez-devel list. Johan, if I forget mention
> any subject or wrote something wrong fix me :)
> 
> 
> 1. HCI signals 
>    Currently, we have the fllowing signals:
>    - InquiryStart
>    - InquiryComplete
>    - InquiryResult
>    - RemoteName
>    These signals are being sent in the
> path /org/bluez/Manager/Controller, and interface
> org.bluez.Manager.Controller
> 
> We have to keep in mind that we need define clean interfaces and paths
> to the CLIENTS  applications. The clients can define filters based on
> paths, interfaces, message types, and member name(service name).
> 
> Johan suggested send the signals to device id based paths and remove
> local BT address from the message argument t.
> eg: /og/bluez/Manager/hci0/Controller

I think this is a good idea.

> 2. Object path
>    We didn't close this discussion. According with the D-Bus guys the
> character ":" is not allowed and the character "-" requires a unstable
> patch.
> 
> I would like define a hierarchical path approach, because it make
> possible the parent level path handle messages sent to a unregistered
> child. eg the /org/bluez/Manager can handle messages sent
> to /org/bluez/Manager/hci2/Controller and return an error message to
> the client instead of return unknown service.
> Another aspect is: if we define an hierarchical paths, it's easier
> find sub-paths and unregister them when we need. eg: unregistering all
> paths related to the hci2 device. The D-Bus function
> dbus_connection_list_registered can list the registered fallback
> handlers and object path handlers at the given parent path,
> eg: /org/bluez/Manager/hci2
> 
> The hci0, hci1, ... ids can change if you remove the dongle. Using the
> device address like AA_BB_CC_DD_EE_FF we will not have this problem. 
> Remember that we are using the hci_dbus_data struct to store the
> device id, It will not be necessary extract the BT address from the
> path for every receive message. Therefore we can ignore this overhead.

I think this makes it a little bit too complex. However I am fully open
to discussion about it.

> 3. DeviceList content
> Johan Question:
> If we device a bluetooth device address based path, which format we
> have to use in the device address field of the DeviceList service?
> AA_BB_CC_DD_EE_FF or AA:BB:CC:DD:EE:FF?

I prefer the AA:BB:CC:DD:EE:FF format, because it is more intuitive.

> 4. Where return the registered paths?
> We need define a service to get all registered paths. My initial idea
> was provide a Introspect method that could return a XML description.
> However, Marcel wrote that can be heavy parse the content. Another
> approach is provide a simple service that return an array of strings
> containing the registered paths. The input argument could be the
> parent path and the return value will be all child paths.

The XML is not a way to go. I like to keep XML out of it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
