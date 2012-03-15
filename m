Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4A079CA2@banasiexm01.ASIA.ROOT.PRI>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44D1AB@DNCE02.ent.ti.com>
	<CAKT1EBcVv1ya0ArmgwNh968O9QSsQD6oNy1poJDeNgg_V=iuog@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B0260B44D4A1@DNCE02.ent.ti.com>
	<F82830D409D80E4881C83250E051B74B4A079B44@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4A079C84@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4A079CA2@banasiexm01.ASIA.ROOT.PRI>
Date: Thu, 15 Mar 2012 10:16:31 -0300
Message-ID: <CACJA=fWYJrSaqq4b5CmuRT2gX6kH9spxE7kBn0uzPdpHmQHDiQ@mail.gmail.com>
Subject: Re: HID Over GATT implementation
From: Andre Guedes <andre.guedes@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Ganir, Chen" <chen.ganir@ti.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

Is this implementation public anywhere?

On Thu, Mar 15, 2012 at 6:47 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
>
> Hi,
>
>>> 3. HID Service - This service contains the main logic for the HOGP, and acts as a proxy between the remote device and the >> local HID subsystems.
>
> I had the HOG Device implemented/tested with the below design. Could you please let me know your opinion about the design?
>
>
> gnome BT mgr
> |
> |
> |
> v
> DBUS                         DBUS
> |                       ^
> |                       |
> |                       |(g_dbus_reg_intf)
> v       (attio_cb)      |
> device <----------> HIDoverGATTplugin
> ^(sock)             ^  ^     ^   |
> |                   |  |     |   |
> |      (notify_buff)|  |     |   |
> |----------------> GATTRIB   |   |
> |                            |   |(ioctl(HIDPCONNADD, HIDP_SCANKEY))
> |            (??outputreport |   |
> |            Notimplemented) |   |                                      US
> ----------------------------------------------------------------------------
> |                            |   |                                      KS
> |                            |   |
> |                            |   V
> v(sock)                     (sock)
> L2CAP                        HIDP<--------------->Input Subsystem
>
>
> Thanks,
> Vijay
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Ganir, Chen
> Sent: Monday, March 12, 2012 11:32 AM
> To: Claudio Takahasi
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: HID Over GATT implementation
>
> Claudio,
>
>> -----Original Message-----
>> From: Claudio Takahasi [mailto:claudio.takahasi@openbossa.org]
>> Sent: Monday, March 12, 2012 2:12 AM
>> To: Ganir, Chen
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: HID Over GATT implementation
>>
>> Hi Chen Ganir,
>>
>> On Sun, Mar 11, 2012 at 9:54 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> > Hi.
>> >
>> > I have started the development of the HOGP (HID Over GATT Protocol)
>> for the BlueZ Stack. The main idea of this adopted profile is to allow
>> HID devices to operate over the low energy technology.
>> >
>> > The HID Over GATT Profile includes the following services :
>> > 1. Battery Service - allows the host to gather and display
>> information regarding the peer device battery/batteries state.
>> > 2. Device Information Service - This service contains misc
>> identification data of a device. The HOGP will use the PNP ID field.
>>
>> Could you please explain how are you planning to share battery level
>> and PNP ID to HoG service?
>>
>> device.c can have function to get/set Battery Level and PNP ID. IMO,
>> only Battery Level could be exported in the Device interface(instead
>> of creating a new interface for Battery).
>>
> PNP ID (or any other DeviceInformation data) and Battery level will be part of the btd_device (later patch). Device will have functionality to get/set the information (get will be exposed externally, set will be for use by the plugins). No specific dbus API will be created for any of those plugins (no need to create an additional interface). Device Information is read once on connection, and when it is read, the plugin updates the btd_device with this information. All available information will be read. There is no need to re-read this during an ongoing connection. If we do see a reason to do that, we can add a dbus interface for it later.
>
> PNP ID is a complex data type. It contains 4 different elements, which will be exposed using a unique structure containing all those values.
>
> Battery information will be read once, and configured for notifications if possible (all done automatically upon connection). Battery level changes will be exposed using D-BUS event (PropertyChanged : BatteryLevel).
>
> Battery level is an integer number, in the range of 0-100. The battery level also has a format characteristic descriptor, which contains a unique namespace/description value which will be used to identify a specific battery, when there is more than one service available. This value will be part of the battery level structure list on the device, and I still need to figure out how to add it to the batterylevel dbus property (maybe append it to the property name, such as BatteryLevel(1) or something like this ?
>
>> BR,
>> Claudio
>
> Chen Ganir,
> Texas Instruments.
> ________________________________________
> �{.n�+�������+%��lzwm��b�맲��r��zX����h��b��^n�r���z���h����&�� �G���h�
> ________________________________________
> (�階�ݢj"���m�����z�ޖ���f���h���~�m�
>
>  To report this email as spam click https://www.mailcontrol.com/sr/wQw0zmjPoHdJTZGyOCrrhg== .
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
