Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <michalski.raf@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Thu, 23 Sep 2010 17:32:12 +0300
Subject: RE: Where "destroying" function definition is ?
Message-ID: <99B09243E1A5DA4898CDD8B700111448097CE2C502@EXMB04.eu.tieto.com>
References: <AANLkTinyQbC30-11CgVtjAhcnbykatBFJJ7rxC4v019L@mail.gmail.com>
In-Reply-To: <AANLkTinyQbC30-11CgVtjAhcnbykatBFJJ7rxC4v019L@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org 
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of 
>Rafa³ Michalski
>Sent: Thursday, September 23, 2010 2:07 PM
>To: linux-bluetooth@vger.kernel.org
>Subject: Where "destroying" function definition is ?
>
>Hi
>
>Does anybody know where "destroying" function is ? - pointer 
>to this function is stored in "destroy" field of agent_request 
>structure, but I can't find definition of this function and 
>place where this pointer (non-NULL) is passed.
>This pointer is used as below - this is a piece of code from 
>BlueZ (release 4.71)
>- src/agent.c file.
>
>static void agent_request_free(struct agent_request *req, 
>gboolean destroy) {
>	if (req->msg)
>		dbus_message_unref(req->msg);
>	if (req->call)
>		dbus_pending_call_unref(req->call);
>	if (req->agent && req->agent->request)
>		req->agent->request = NULL;
>	if (destroy && req->destroy)
>		req->destroy(req->user_data);
>			/* where is the function that destroy 
>points to ??? */
>	g_free(req);
>}
>
>Thanks for any help.
>
>Best regards
>Rafa³ Michalski

I'm not pretty sure but this feature seems be not used :) 
In device.c  function device_request_authentication() calls agent_request_*  with NULL as the last param which is fact is a pointer to "distroying" function.


Regards,
/Waldek