Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B478529E4@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
	<CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
	<7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
	<F82830D409D80E4881C83250E051B74B478523E8@banasiexm01.ASIA.ROOT.PRI>
	<F0070FBC0FB3174D8D11444EB2D5B0260106E6@DNCE02.ent.ti.com>
	<F82830D409D80E4881C83250E051B74B478529E4@banasiexm01.ASIA.ROOT.PRI>
Date: Tue, 8 Nov 2011 15:56:53 +0200
Message-ID: <CABBYNZ+k+Bra9pZuCcLo1jgpaerteOaAxZS8+eMt_ikT3uwb6A@mail.gmail.com>
Subject: Re: Proposal for GATT Client Dbus API.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 7, 2011 at 3:35 PM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> Hi Chen,
> Below is the latest diff, with all the changes incorporated. Let me know your view.
>
> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
> index 98d7f30..9dd8222 100644
> --- a/doc/attribute-api.txt
> +++ b/doc/attribute-api.txt
> @@ -110,6 +110,20 @@ Methods            dict GetProperties()
>                        read-write properties can be changed. On success
>                        this will emit a PropertyChanged signal.
>
> +               void GetCharacteristicValue(uint16 timeout)

The interface name already is org.bluez.Characteristic so we really
need Characteristic again.

> +                       Read the value of the characteristic with timeout value in seconds.
> +                       This will emit a ReadResponse signal with status code.

Why you don't return an error? Signals are not that great here, you
also want to track the caller so that if it exit you cancel the
operation.

> +               void SetCharacteristicValue(variant value, string method, uint16 offset, uint16 timeout)
> +
> +                       Changes the value of the specified characteristic as per the offset and method, with timeout value in seconds.
> +                       This will emit a WriteResponse signal with status code.
> +
> +                       Write the value of the characreristic, with any of these specified method:
> +                       "WriteWithResponse", "SignedWriteWithoutResponse",
> +                       "WriteLongCharacteristicValue", "PrepareWrite", "ExecuteWrite".
> +

Same here, signals are useful for async events not for response, also
you are mixing terminology of set/get with read/write, either use one
or the other.

>                        Possible Errors: org.bluez.Error.InvalidArguments
>
>  Properties     string UUID [readonly]
> @@ -126,7 +140,41 @@ Properties         string UUID [readonly]
>                        Textual optional characteristic descriptor describing
>                        the Characteristic Value.
>
> +               boolean Broadcast [readwrite]
> +
> +                       Indicates whether this characteristic is broadcasted or not.
> +                       If GATT Server Characteristic Configuration descriptor
> +                       is not available for this characteristic, or if the characteristic
> +                       properties do not allow this, writing to this property is not
> +                       allowed.
> +
> +               boolean Indicate [readwrite]
> +
> +                       Indicates whether this characteristic is notified or not.
> +                       If GATT Client Characteristic Configuration descriptor
> +                       is not available for this characteristic, or if the characteristic
> +                       properties do not allow this, writing to this property is not
> +                       allowed.
> +
> +               boolean Notify [readwrite]
> +
> +                       Indicates whether this characteristic is indicated or not.
> +                       If GATT Client Characteristic Configuration descriptor
> +                       is not available for this characteristic, or if the characteristic
> +                       properties do not allow this, writing to this property is not
> +                       allowed.
> +
> +               boolean Readable [readonly]
> +
> +                       Indicates wether this characteristic value can be read.
> +
> +               array{string} WriteMethods [readonly]
> +
> +                       Write methods supported by the characteristic, includes extended properties if defined, format defined by GATT spec.
> +                       Possible values:
> +                       { "WriteWithoutResponse", "Write", "AuthenticatedSignedWrite", "ReliableWrite", "WritableAuxiliaries"}
> +
>
> -               struct Format [readonly]
> +               array{struct} Format [readonly]
>
>                        Optional Characteristic descriptor which defines the
>                        format of the Characteristic Value. For numeric
> @@ -142,6 +190,11 @@ Properties         string UUID [readonly]
>                          uint16 | Description: Description of the characteristic defined
>                                 | in a high layer profile.
>
> +               array{object} CustomCharacteristicsDesc [readonly]
> +
> +                       This list contains the user defined characteristics descriptors owned by this
> +                       specific characteristics.
> +
>                array{byte} Value [readwrite]
>
>                        Raw value of the Characteristic Value attribute.
> @@ -162,3 +215,11 @@ Object path        freely definable
>  Methods                void ValueChanged(object characteristic, array{byte})
>
>                        New raw value of the Characteristic Value attribute.
> +
> +               void ReadResponse(object characteristic, uint8 status, variant value)
> +
> +                       Value read and status code for Read Characteristic Value attribute operation.
> +
> +               void WriteResponse(object characteristic, uint8 status)
> +
> +                       Status code for Write Characteristic Value attribute opeartion.



-- 
Luiz Augusto von Dentz
