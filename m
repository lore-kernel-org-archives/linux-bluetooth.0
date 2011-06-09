Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Date: Thu, 9 Jun 2011 11:45:38 +0300
Subject: RE: [PATCH 1/2] Add RequestSecurePinCode to agent API
Message-ID: <99B09243E1A5DA4898CDD8B700111448175AA2DB9B@EXMB04.eu.tieto.com>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110608175648.GA13036@joana>
In-Reply-To: <20110608175648.GA13036@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 
Hi Gustavo,

>Why RequestPinCode() isn't enough? It can accept up to 16 characters.
>Alternatively we can add a Property to tell when to use pin 
>code or not.
>
>For BlueZ 5.0 we can break this and add a length param to 
>RequestPinCode().
>

It's not really matter of the length but the agent needs to know if secure pincode is required.

RequestSecurePinCode doesn't break existing API as it's used with mgmtops only. If we go for  RequestPinCode(boolean secure) this will break the API immediately.
Property? Do you mean agent, adapter or device property? 

Well,  RequestSecurePinCode seems to be the most clean solution for me, but of course it's a matter of discussion.


Waldek




