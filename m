Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Sep 2010 14:06:53 +0200
Message-ID: <AANLkTinyQbC30-11CgVtjAhcnbykatBFJJ7rxC4v019L@mail.gmail.com>
Subject: Where "destroying" function definition is ?
From: =?ISO-8859-2?Q?Rafa=B3_Michalski?= <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

Does anybody know where "destroying" function is ? - pointer to this function is
stored in "destroy" field of agent_request structure, but I can't find
definition
of this function and place where this pointer (non-NULL) is passed.
This pointer is used as below - this is a piece of code from BlueZ
(release 4.71)
- src/agent.c file.

static void agent_request_free(struct agent_request *req, gboolean destroy)
{
	if (req->msg)
		dbus_message_unref(req->msg);
	if (req->call)
		dbus_pending_call_unref(req->call);
	if (req->agent && req->agent->request)
		req->agent->request = NULL;
	if (destroy && req->destroy)
		req->destroy(req->user_data);
			/* where is the function that destroy points to ??? */
	g_free(req);
}

Thanks for any help.

Best regards
Rafa³ Michalski
