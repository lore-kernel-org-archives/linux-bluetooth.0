Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329241945-32414-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
	<1329241945-32414-2-git-send-email-anderson.lizardo@openbossa.org>
Date: Wed, 15 Feb 2012 09:50:11 +0100
Message-ID: <CACLukz+nFbUn141XYsN91asx=BT=O1sK3s=__tEr7W+JVK6dyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] thermometer: Fix handling of missing
 Temperature Type
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

2012/2/14 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> According to HTS 1.0, it is not mandatory to have Temperature Type
> information (the Characteristic and the indication field are both
> unconditionally optional).
>

I'm afraid there is an slight conceptual error in this patch.
According to HTS 1.0, there are two *exclusive* methods to provide the
temperature type to a Colector: either by using a characteristic type
or providing it as a field within the measurement. This doesn't mean
that the temperature characteristic or field type are both
unconditionally optional because one of them *MUST* be used, but not
both of them at the same time. So there will always be a method to get
the temperature type either if it's a static value (characteristic
type) or a non-static value (temperature field). Health Thermometer
Service[3.2] ,[3.1] &  Health Thermometer Profile [4.7]


Regards.
Santiago
