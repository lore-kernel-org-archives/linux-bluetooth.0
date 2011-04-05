Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Tue, 5 Apr 2011 16:38:09 +0300
Subject: RE: [PATCH v2] Add sap_disconnect_ind interface for sap-sim drivers
Message-ID: <99B09243E1A5DA4898CDD8B7001114481085FBEEE1@EXMB04.eu.tieto.com>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325091759.GA1150@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114481085E2325E@EXMB04.eu.tieto.com>
 <20110328095557.GA11511@jh-x301>
In-Reply-To: <20110328095557.GA11511@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>> The original idea was to have Disconnect(type) method in 
>server.c, but 
>> finally, in a discussion, we came to the conclusion that the 
>immediate 
>> disconnect should not be used by user. Driver should handle this if 
>> it's needed.
>> 
>> So, sap-api.txt stays unchanged, and dummy-driver is changed to be 
>> able to pass some of  PTS tests.
>
>Ok, sounds fine to me.

Are you going to push upstram this patch ?

Waldek
