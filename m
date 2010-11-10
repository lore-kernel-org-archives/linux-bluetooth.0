Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <suraj@atheros.com>,
	<johan.hedberg@gmail.com>, <joakim.xj.ceder@stericsson.com>
Date: Wed, 10 Nov 2010 13:12:53 +0200
Subject: RE: [PATCH 1/4] Sim Access Profile API
Message-ID: <99B09243E1A5DA4898CDD8B7001114480BD700C239@EXMB04.eu.tieto.com>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1289367190.9615.235.camel@aeonflux>
In-Reply-To: <1289367190.9615.235.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=20

>> +		void Disable()
>> +
>> +			Shudown SAP server and remove the SDP record.
>> +
>> +			Possible errors: org.bluez.Error.Failed
>
>I don't like this. If you have properties then just changing=20
>the property should be enough. So a SetProperty is more appropriate.

I see another option to get rid of 'Enabled' property and leave the methods=
. What would you say on that?

>> +
>> +		void Disconnect(boolean type)
>> +
>> +			Disconnect SAP client from the server.=20
>The 'type'
>> +			parameter indicates disconnection type.
>> +
>> +			True  - gracefull disconnection
>> +			False - immediate disconnection
>> +
>> +			Possible errors: org.bluez.Error.Failed
>
>I don't like this style of method names at all. Using method=20
>names like GracefulDisconnect and ImmediateDisconnect would be better.

That's fine.

>However I am not sure we should differentiate here at all. We=20
>should always to the graceful disconnect. What will the=20
>immediate disconnect bring us?

That's actually intended for testing only. One of PTS test cases expects th=
e tester to trigger immediate disconnect.
In practce, it is only used when connection to sim card is lost, but this i=
s obviously done internally.

Thanks,
/Waldek=
