Return-Path: <cyrus@holtmann.org>
From: Nitish Wokkadada <nitishw@marvell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 3 Mar 2015 22:59:49 -0800
Subject: RE: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using
 Immediate_Alert Service(Single Instance Service) used by multiple Profiles
Message-ID: <CBACCFA0AEB13A41977475BCF3E896FC6674695156@SC-VEXCH2.marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
Can anyone please comment?

Regards,
Nitish Wokkadada

-----Original Message-----
From: Nitish Wokkadada 
Sent: 27 February 2015 18:16
To: 'linux-bluetooth@vger.kernel.org'
Subject: Query: [BLE][PROFILES]Need Suggestion on Implementing/Using Immediate_Alert Service(Single Instance Service) used by multiple Profiles

Hello,

Currently in Bluez5.28, I see the immalert.c & immalert.h files under folder profiles/proximity, wherein just Proximity profile uses/adds the Immediate_Alert Service & hence the immalert.c contains the handling with respect to Proximity Profile.
However Immediate_Alert Service is a common service, and also can be used by FindMe Profile. 

So, if we are implementing the FindMe Profile(FindMeTarget Role/GATT Server Role), then we cannot have another file in profiles/findme/ that adds the immediate_alert service(Considering Device supports both Proximity and FindMe profiles) due to immediate_alert service shall have a Single Instance per Device. 
Also in Client Role case, we need to have common code for Single Instance Services(similar to Immediate_alert service) that does the discovery, read, write operations by providing apis that can be used by Different Profiles(ex: Proximity and FindMe profiles that uses Immediate_alert service), similar to Device Information service.

Kindly correct me if my understanding is incorrect and suggest me on how to go about on implementing FindMe Profile(Whether to make a common ImmediateAlert file similar to DeviceInfo that can be used by required profiles)

Regards,
Nitish W
