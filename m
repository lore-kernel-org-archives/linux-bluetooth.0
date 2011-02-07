Return-Path: <cyrus@holtmann.org>
Message-ID: <4D4FF756.4030001@hschmitt.de>
Date: Mon, 07 Feb 2011 14:44:54 +0100
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Waldemar.Rymarkiewicz@tieto.com
Subject: Re: [PATCH] Sim Access Profile API
References: <4D4FE85E.4010108@hschmitt.de> <4D4FEA59.9010607@hschmitt.de> <99B09243E1A5DA4898CDD8B700111448107E6AB9F2@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448107E6AB9F2@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 07.02.2011 14:31, schrieb Waldemar.Rymarkiewicz@tieto.com:
> Hi, 
> 
>> Am 07.02.2011 13:41, schrieb Harald Schmitt:
>>> New API for Sim Access Profile by Waldemar Rymarkiewicz
>>> ---
>>>  Makefile.am     |    3 ++-
>>>  doc/sap-api.txt |   34 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 36 insertions(+), 1 deletions(-)  create 
>> mode 100644 
>>> doc/sap-api.txt
>>>
>>> diff --git a/Makefile.am b/Makefile.am index e6639a7..7975dfa 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -354,7 +354,8 @@ EXTRA_DIST += doc/manager-api.txt \
>>>  		doc/service-api.txt doc/agent-api.txt 
>> doc/attribute-api.txt \
>>>  		doc/serial-api.txt doc/network-api.txt \
>>>  		doc/input-api.txt doc/audio-api.txt 
>> doc/control-api.txt \
>>> -		doc/hfp-api.txt doc/health-api.txt 
>> doc/assigned-numbers.txt
>>> +		doc/hfp-api.txt doc/health-api.txt doc/sap-api.txt \
>>> +		doc/assigned-numbers.txt
>>>   AM_YFLAGS = -d
>>>  diff --git a/doc/sap-api.txt b/doc/sap-api.txt new file mode 100644 
>>> index 0000000..b8b7253
>>> --- /dev/null
>>> +++ b/doc/sap-api.txt
>>> @@ -0,0 +1,34 @@
>>> +BlueZ D-Bus Sim Access Profile API description
>>> +***********************************
>>> +
>>> +Copyright (C) 2010 ST-Ericsson SA
>>> +
>>> +
>>> +Sim Access Profile hierarchy
>>> +============================
>>> +
>>> +Service		org.bluez
>>> +Interface	org.bluez.SimAccess
>>> +Object path	[variable prefix]/{hci0,hci1,...}
>>> +
>>> +Methods		void Disconnect()
>>> +
>>> +			Disconnects SAP client from the server.
>>> +
>>> +			Possible errors: org.bluez.Error.Failed
>>> +
>>> +		dict GetProperties()
>>> +
>>> +			Return all properties for the interface. See the
>>> +			properties section for available properties.
>>> +
>>> +			Possible Errors: org.bluez.Error.Failed
>>> +
>>> +Signals		PropertyChanged(string name, variant value)
>>> +
>>> +			This signal indicates a changed value 
>> of the given
>>> +			property.
>>> +
>>> +Properties	boolean Connected [readonly]
>>> +
>>> +			Indicates if SAP client is connected to 
>> the server.
>>
>> I took the patch from Waldemar Rymarkiewicz (2010-12-02) and 
>> did the restructuring in Makefile.am as commented from Gustavo 
>> F. Padovan.
>> Are there any other comments?
> 
> 
> What kind of restructuring did you do? I cannot notice any difference.
> Is this just a rebase ?
> 
It is a rebase in the end. The only change is that I put
doc/assigned-numbers.txt at the end of EXTRA_DIST as commented by
Gustavo. Feel free to submit it again with your credentials. I just
wanted to see if this very, very small change prevented your patch from
being pushed. As I am very keen to see a progress on SimAccess.

Best regards,
Harald
