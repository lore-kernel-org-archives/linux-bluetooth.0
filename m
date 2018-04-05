Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: How to un-pair a device via DBus
To: Libor Peltan <lpeltan@insys-tec.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <AM3PR06MB0838B8DD1EDF9B387B98E3ED9AA40@AM3PR06MB0838.eurprd06.prod.outlook.com>
From: Ravi Minnikanti <ravichandraminnikanti@gmail.com>
Message-ID: <3c9ba361-bf93-9424-9dc3-f69be91ef919@gmail.com>
Date: Thu, 5 Apr 2018 10:37:01 +0530
MIME-Version: 1.0
In-Reply-To: <AM3PR06MB0838B8DD1EDF9B387B98E3ED9AA40@AM3PR06MB0838.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You can use RemoveDevice method from org.bluez.Adapter1 interface.

See 
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt

-Ravi

On 04-04-2018 21:10, Libor Peltan wrote:
> Hello,
> I'm asking just for a hint, how to do stuff, as I'm probably missing something obvoius.
> 
> My application controls all bluetooth events and options via DBus interface. I already use Connect/Disconnect methods of devices, their Trusted property etc., as described here:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt
> 
> However, when I call CancelPairing method, I always receive DoesNotExist error.
> 
> My intention is to remove a paired device from the devices list, or at least mark is as "not paired", so that the device must pair again before anything else.
> 
> Please note that setting the Paired property to "off" does not work as this property is read-only.
> 
> Also the solution of deleting the device's directory is not a good option for me as the bluetooth daemon would probably need to be restarted.
> 
> How to invoke device removal or un-pair via DBus ?
> 
> Thanks for any answers!
> Libor Peltan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
