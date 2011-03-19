Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144810830AAEF3@EXMB04.eu.tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300277421-8053-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<AANLkTinF695CSLoSgxCn1LOiZ=jF-Z8OjAsEeY52K8GG@mail.gmail.com>
	<99B09243E1A5DA4898CDD8B70011144810830AAEF3@EXMB04.eu.tieto.com>
Date: Sat, 19 Mar 2011 15:57:21 +0100
Message-ID: <AANLkTinM-5ZfMYb61PAbcN1tfTTLVsFq1Sc-5wOhTi5_@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] Add support for SAP protocol
From: "ANGUS.H" <hombre71@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 17, 2011 at 10:50 AM,  <Waldemar.Rymarkiewicz@tieto.com> wrote:
> Hi Angus.H,
>
>>A lot of code could be refactored.
>>Quite a few repeatable (logically) blocks in every
>>"...._req()" and "..._rsp()" handlers.
>>
>
> Indeed, but those blocks are not equal in all cases. Thus, I prefere to split it up into seperate functions instead of having one big function with switch-case statement.
> It's not like we can replace those blocks with one generic function without switch-case.  I consider this as slightly more readable. However, I'm not strongly opposed to change it one function.
>
> Waldek
>

Hi
I just wanted to say that refactoring of typical req() here could be
seen as 3 or 4 internal prcedure calls,
[ refactoring here == extracting common/repeatable code to new routine ]

typical req example:
static void power_sim_off_req(struct sap_connection *conn)
 {
-       DBG("SAP_SIM_OFF_REQUEST");
+       DBG("conn %p state %d", conn, conn->state);
+
+       if (conn->state != SAP_STATE_CONNECTED)
+               goto error_rsp;
+
+       if (!is_power_sim_off_req_allowed(conn->processing_req))
+               goto error_rsp;
+
+       conn->processing_req = SAP_POWER_SIM_OFF_REQ;
+       sap_power_sim_off_req(conn);
+
+       return;
+
+error_rsp:
+       error("Processing error (state %d pr 0x%02x)", conn->state,
+                                               conn->processing_req);
+       sap_error_rsp(conn);
 }

could be represented as:
{
validate_req(conn, VALIDATION_RULE)
assign_req(conn,REQ)
send_req(conn, handlers[REQ])  ( where handlers is an array of req/rsp
handlers to sap driver )
error_handling:
}


it's just an example, more readable/maintainable.
/AH
