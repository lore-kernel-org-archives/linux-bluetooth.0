Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4765B7BC10CB4C488A56C73E15D6FBA31DA368123F@EXDCVYMBSTM005.EQ1STM.local>
References: <4765B7BC10CB4C488A56C73E15D6FBA31DA368123F@EXDCVYMBSTM005.EQ1STM.local>
Date: Thu, 23 Dec 2010 17:41:42 -0300
Message-ID: <AANLkTimtoNKxdk13hAoJeqva_RQVvvNNFqkHy7LOuij9@mail.gmail.com>
Subject: Re: [PATCH] Updated TODO list for LE HCI Scan, Advertise and Connect commands.
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Sumit Kumar BAJPAI <sumitkumar.bajpai@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sumit,

On Thu, Dec 23, 2010 at 7:07 AM, Sumit Kumar BAJPAI
<sumitkumar.bajpai@stericsson.com> wrote:
> Updated TODO list for HCI commands for LE that ST-Ericsson plans to
> implement and contribute back.
>
> ---
>  TODO |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)
>
> diff --git a/TODO b/TODO
> index 49a9e76..e62c6e5 100644
> --- a/TODO
> +++ b/TODO
> @@ -66,6 +66,99 @@ Low Energy
>   Priority: Low
>   Complexity: C2
>
> +- Implement Set Advertise data via Host interface. This Set Advertise Data is
> +  used by advertising device to advertise with some data field. This is via
> +  undirected and connectable events. Data field is maximum of 30 octets, and is
> +  primarily used for small data advertisement. Scanning device can see in scan
> +  results the advertised data as set by the advertising device.
> +  See Volume 2, Part E, section 7.8.7 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement Set Advertise parameters via Host interface. This Set Advertise
> +  parameters is used by advertising device to set advertising parameters. The
> +  Host shall not issue this command when advertising is enabled in the
> +  Controller; if it is the Command Disallowed error code shall be used.
> +  See Volume 2, Part E, section 7.8.5 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement Set Scan Response Data via host interface. This data is set by the
> +  advertiser in case it wants to send data only to those devices that are
> +  currently actively scanning. This is via undirected and connectable events.
> +  Data can be set before or after advertising and can be maximum of 30 octets.
> +  See Volume 2, Part E, section 7.8.8 for more information.
> +
> +  Priority: Low
> +  Complexity: C1

We don't need to expose a method to allow the applications to change
the advertising parameters. The idea is to manage them automatically
based on the registered gatt servers.
Broadcaster Role is out of scope at the moment. Peripheral, we are
planning to start the implementation soon, but first we need to define
the GATT server API.
IMHO we need to align the advertising parameter settings with the
Adapter "Discoverable" property and the registered GATT servers.
Set Scan Response Data: I don't an answer at the moment.

> +
> +- Implement Read Advertise Channel Tx Power via Host interface. This Read
> +  Advertise Channel Tx power is used by advertising host to read the transmit
> +  power level used for LE advertising channel packets.
> +  See Volume 2, Part E, section 7.8.6 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
Could you please give an usage example?
If I understood correctly we will need a function
hci_le_read_xxx_tx_power() to fill the TX Power Level in the
advertising data, right?

> +
> +- Implement Add Device to White List in LE controller via host interface.
> +  This command is used to add a single device to white list stored in the
> +  controller. Once the device is in white list it should follow scan and
> +  connect rules as stated in advertising filter policy.
> +  See Volume 2, Part E, section 7.8.16 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement Remove Device from White List in LE controller via host interface.
> +  This command is used to remove a single device from white list stored in the
> +  controller. This command has certain restrictions on its usage. Command
> +  complete event is generated on completion.
> +  See Volume 2, Part E, section 7.8.17 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement Clear White List in LE controller via host interface. This command
> +  is used to clear the white list stored in the controller. This command has
> +  certain restrictions  on its usage. This command has no command parameters
> +  to be pushed on  controller. Command complete event is generated on completion.
> +  See Volume 2, Part E, section 7.8.15 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement Read White List Size in LE controller via host interface. This
> +  command is used to read the maximum size of the white list supported by the
> +  controller.
> +  See Volume 2, Part E, section 7.8.14 for more information.
> +
> +  Priority: Low
> +  Complexity: C1

Maybe we will need this feature to implement the Register Application
API. Automatic connections are planned, but it can be useful to
reduce/filter the amount of advertising reports.

> +
> +- Implement Read LE buffer Size via host interface. This data is used to read
> +  the maximum size of data portion of HCI LE ACL Data Packets sent from the
> +  Host to the Controller. The Host will segment the data transmitted to the
> +  Controller according to these values, so that the HCI Data Packets will
> +  contain data with up to this size. The LE_Read_Buffer_Size command also
> +  returns the total number of HCI LE ACL Data Packets that can be stored in
> +  the data buffers of the Controller. The LE_Read_Buffer_Size command must be
> +  issued by the Host before it sends any data to an LE Controller.
> +  See Volume 2, Part E, section 7.8.2 for more information.
> +
> +  Priority: Low
> +  Complexity: C1
> +
> +- Implement LE Connection Update command via Host interface. The
> +  LE_Connection_Update command is used to change the Link Layer connection
> +  parameters of a connection. This command shall only be used when the local
> +  device's role is Master.
> +  See Volume 2, Part E, section 7.8.18 for more information.
> +
> +  Priority: Medium
> +  Complexity: C1

Is it necessary to notify the userpace or it is a kernel task only?
Please remove it if it is a kernel task.

For the other tasks I suggest to keep them in the TODO file to track
the missing features, no matter if we will use them directly(eg:
hcitool, hciconfig) or in the API/services implementation.
If possible please add the expected deliverable for each task, it will
make easier to other developers to contribute.

Regards.
Claudio
