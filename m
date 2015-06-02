Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9425D49D@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1432325420-12782-1-git-send-email-ifaenson@broadcom.com>
 <1432325420-12782-2-git-send-email-ifaenson@broadcom.com> <CAL_JsqLO+g56KYUocpWLpz4dDTP0fEXTa4RjJzeRsPvYjCyF4A@mail.gmail.com>
 <E0D3336E15B58B4294723AC879BA5E9425D49D@IRVEXCHMB15.corp.ad.broadcom.com>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 2 Jun 2015 10:34:27 -0500
Message-ID: <CAL_Jsq+iGtfB8JSdL-b6jTnFUPxQiJoR2VAb1rFv8MODnFoJLQ@mail.gmail.com>
Subject: Re: [RFC v4 1/4] Broadcom Bluetooth UART Device Tree bindings
To: Ilya Faenson <ifaenson@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arend Van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 2, 2015 at 7:20 AM, Ilya Faenson <ifaenson@broadcom.com> wrote:
> Hi Rob,
>
> Appreciate your insights.
>
> -----Original Message-----
> From: Rob Herring [mailto:robherring2@gmail.com]
> Sent: Monday, June 01, 2015 8:19 PM
> To: Ilya Faenson
> Cc: Marcel Holtmann; linux-bluetooth@vger.kernel.org; devicetree-spec@vge=
r.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [RFC v4 1/4] Broadcom Bluetooth UART Device Tree bindings
>
> On Fri, May 22, 2015 at 3:10 PM, Ilya Faenson <ifaenson@broadcom.com> wro=
te:
>> Device Tree bindings to configure the Broadcom Bluetooth UART device.
>>
>> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
>> ---
>>  .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 +++++++++++++++=
+++++++
>>  1 file changed, 82 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbc=
m.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b=
/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>> new file mode 100644
>> index 0000000..968421b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>> @@ -0,0 +1,82 @@
>> +btbcm
>> +------
>> +
>> +Required properties:
>> +
>> +       - compatible : must be "brcm,brcm-bt-uart".
>> +       - tty : tty device connected to this Bluetooth device.
>
> Neil Brown has been working on generic bindings for tty/UART slaves
> which should be used here.
>
> IF: I certainly like what is being developed for the UART child devices i=
n the DeviceTree. It will finally catch up with what's been available in th=
e ACPI for years. However, to the best of my understanding, that effort is =
currently not in the bluetooth-next git repo. As Marcel told me earlier thi=
s year, "if it is not in the bluetooth-next, it does not exist". I'm afraid=
 I can't use it therefore. Also, we need to ship this driver sooner rather =
than later. The integration with the UART slave devices sounds like a worth=
while future enhancement to me.

If you merged this and then used the UART slave devices later, then
you have to support both bindings as the bindings are an ABI. We have
enough cases of that because we did not have the foresight to avoid
it. In this case we do. You have not given me any reason why other
than timing and that's not a valid reason.

>
>> +
>> +Optional properties:
>> +
>> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an inter=
rupt.
>> +
>> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume =
device.
>> +
>> +  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/=
off.
>> +
>> +  - baud-rate-before-config-download : initial Bluetooth device baud ra=
te.
>> +    Default: 3000000.
>
> What's the baudrate after download? Why not just use standard
> "baud-rate" if you only specify one rate?
>
> IF: You're right: this doc used to list two rates. :-) To be compatible w=
ith what Intel is doing in the same area, I will call it "oper-speed" if yo=
u don't mind.

So you need 2 values or not?

>> +
>> +  - manual-fc : flow control UART in suspend / resume scenarios.
>> +    Default: 0.
>> +
>> +  - configure-sleep : configure suspend / resume flag.
>> +    Default: false.
>> +
>> +  - configure-audio : configure platform PCM SCO flag.
>> +    Default: false.
>> +
>> +  - PCMClockMode : PCM clock mode. 0-slave, 1-master.
>> +    Default: 0.
>> +
>> +  - PCMFillMethod : PCM fill method. 0 to 3.
>> +    Default: 2.
>> +
>> +  - PCMFillNum : PCM number of fill bits. 0 to 3.
>> +    Default: 0.
>> +
>> +  - PCMFillValue : PCM fill value. 0 to 7.
>> +    Default: 3.
>> +
>> +  - PCMInCallBitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512=
Kbps,
>> +    3-1024Kbps, 4-2048Kbps.
>> +    Default: 0.
>> +
>> +  - PCMLSBFirst : PCM LSB first. 0 or 1.
>> +    Default: 0.
>> +
>> +  - PCMRightJustify : PCM Justify. 0-left, 1-right.
>> +    Default: 0.
>> +
>> +  - PCMRouting : PCM routing. 0-PCM, 1-SCO over HCI.
>> +    Default: 0.
>> +
>> +  - PCMShortFrameSync : PCM sync. 0-short, 1-long.
>> +    Default: 0.
>> +
>> +  - PCMSyncMode : PCM sync mode. 0-slave, 1-master.
>
> Please no CamelCase. These need better descriptions.
>
> IF: I am certainly aware that the CamelCase is generally not used on Linu=
x. The Broadcom however have a spec describing what needs to be done to int=
egrate these kinds of chips on hardware platforms (for Windows). Anybody wh=
o wishes to use SCO PCM audio will need to read that spec. These parameter =
names are from that spec. A lot of additional technical info Is there, alon=
g with various diagrams. It can't be all placed in this help file. Of cours=
e, I can change these parameter names but it would make things harder for t=
hose wishing to use the hardware as they would not match the spec. Could yo=
u make an exception?

I think humans are capable to translate. Besides, I don't really care
so much what is in Broadcom's spec (besides the fact I probably don't
have access). What I care about is what does the PCM configuration
look like for the next BT uart chip with a DT binding that comes
along. I don't want to see $vendor specific fields just dumped into DT
as is with no regard to whether things should be common. Some of this
is pretty Broadcom specific, but much of it is standard PCM/I2S audio
configuration.

Rob
