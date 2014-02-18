Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v6 00/18] GATT API: External Services
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKT1EBdeyQDXbgu5iv3CC=XAE0j-dKVTOp8HMNuA7=xyK8ri0g@mail.gmail.com>
Date: Tue, 18 Feb 2014 10:17:50 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <1B88D85B-35F3-47BB-ACAD-872E6C4F0A79@holtmann.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org> <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org> <B6CE0C86-8DC9-45D1-8022-78ED9D83B96F@holtmann.org> <CAKT1EBdeyQDXbgu5iv3CC=XAE0j-dKVTOp8HMNuA7=xyK8ri0g@mail.gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

>>> This patchset implements the minimal support for adding local services
>>> declarations.
>>> 
>>> Limitation: Remove services and multiple services exported by the same
>>> remote will be implemented the next series.
>> 
>> what is the deal with this unix socket you are using for local access? I think we should remove that functionality and keep it simple in the beginning.
> 
> Testing purpose only to avoid breaking the current attribute server.
> The fact is, the current attribute server "architecture" is not
> flexible enough to support external services properly.
> The idea is to get rid of the "old" attribute server when we finish
> the new implementation.
> 
> Lizardo has some patches allowing compatibility between the two
> versions. We will send new patchsets to remove the unix socket, and
> introduce this compatibility.

that sounds better. I rather not have an extra unix socket based API around. We are still having a heard time to get rid of the SDP unix socket.

Regards

Marcel

