Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b621074b0704162102u3100c63ax15be998c472ecf3f@mail.gmail.com>
Date: Tue, 17 Apr 2007 09:32:27 +0530
From: "Tushar Paturde" <tusharpaturde@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176727272.30165.2.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <b621074b0704160159pc7e4f6l65e849875d0ab676@mail.gmail.com>
	<1176727272.30165.2.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Where does the Bluez stores registered services?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1889084489=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1889084489==
Content-Type: multipart/alternative;
	boundary="----=_Part_60915_1895042.1176782547704"

------=_Part_60915_1895042.1176782547704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
The code snippet  that I'm using for registering  new service record is as
below .

#define BT_INVALID_SDDB_HANDLE 0
....
bt_result_t bt_sddb_update_record(bt_record_t *record)
{
    int scanned;
    sdp_record_t *rec = sdp_extract_pdu((uint8_t *)record->data, &scanned);
    if (rec == NULL) {
        return BT_RESULT_FAILURE;
    }

    if (record->id == BT_INVALID_SDDB_HANDLE) {
        if (sdp_record_register(g_sess, rec, 0) < 0) {
            sdp_record_free(rec);
            return BT_RESULT_FAILURE;
        }
        record->id = (bt_sddbid_t)rec->handle;
        return BT_RESULT_SUCCESS;
    } else {
        int retval;
        rec->handle = record->id;
        retval = sdp_record_update(g_sess, rec);
        sdp_record_free(rec);
        if (retval < 0) {
            return BT_RESULT_FAILURE;
        }
        record->id = (bt_sddbid_t)rec->handle;
        return BT_RESULT_SUCCESS;
    }
}


In this code sdp_record_register return with success but the  value of
"rec->handle " is set to zero (0).  This is problem for me. I think the
value should be greater than zero or ideally 1. Because the "record" that is
passed with service information has set it's handle to zero i.e it point to
the default service record.

This is causes problem in the upper layer of java implementation . So I need
to kill the app manually at present. But it seems "sdp_record_register"
operation is success because the registered service can be  browsed by
external device.


Regards,

Tushar

NB: This code snippet is part of phonme project jsr82 implementation
btSDDB.c .


On 4/16/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Tushar,
>
> > I had registered one btl2cap service  using Bluez api's . Even after
> > stopping the service it is still returned by service discovery done
> > from another device. I would like to know where is the registry of
> > these services maintained by bluez library.  Also how can I modify
> > this services registry ?
>
> if the service record doesn't disappear, then your code is wrong. You
> have used persistent SDP records. Don't do that. And it is even better
> to register the service records over D-Bus.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Tushar Paturde

------=_Part_60915_1895042.1176782547704
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>The code snippet&nbsp; that I&#39;m using for registering&nbsp; new service record is as below .<br><br>#define BT_INVALID_SDDB_HANDLE 0<br>....<br><div style="margin-left: 40px;">bt_result_t bt_sddb_update_record(bt_record_t *record)
<br>{<br>&nbsp;&nbsp;&nbsp; int scanned;<br>&nbsp;&nbsp;&nbsp; sdp_record_t *rec = sdp_extract_pdu((uint8_t *)record-&gt;data, &amp;scanned);<br>&nbsp;&nbsp;&nbsp; if (rec == NULL) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BT_RESULT_FAILURE;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; if (record-&gt;id == BT_INVALID_SDDB_HANDLE) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdp_record_register(g_sess, rec, 0) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_record_free(rec);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BT_RESULT_FAILURE;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: rgb(51, 204, 255);">&nbsp; record-&gt;id = (bt_sddbid_t)rec-&gt;handle;
</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BT_RESULT_SUCCESS;<br>&nbsp;&nbsp;&nbsp; } else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rec-&gt;handle = record-&gt;id;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = sdp_record_update(g_sess, rec);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_record_free(rec);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval &lt; 0) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BT_RESULT_FAILURE;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record-&gt;id = (bt_sddbid_t)rec-&gt;handle;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BT_RESULT_SUCCESS;<br>&nbsp;&nbsp;&nbsp; }<br>}<br></div><br><br>In this code sdp_record_register return with success but the
<span style="background-color: rgb(255, 255, 255);">&nbsp; value of &quot;rec-&gt;handle &quot; is set to zero (0).&nbsp; This is problem for me. I think the value should be greater than zero or ideally 1. Because the &quot;</span>
record&quot; that is passed with service information has set it&#39;s handle to zero i.e it point to the default service record.&nbsp; <br><br>This is causes problem in the upper layer of java implementation . So I need to kill the app manually at present. But it seems &quot;sdp_record_register&quot; operation is success because the registered service can be&nbsp; browsed by external device.
<br><br><br>Regards,<br><br>Tushar<br><br>NB: This code snippet is part of phonme project jsr82 implementation btSDDB.c .<br><br><br><div><span class="gmail_quote">On 4/16/07, <b class="gmail_sendername">Marcel Holtmann</b>
 &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Tushar,
<br><br>&gt; I had registered one btl2cap service&nbsp;&nbsp;using Bluez api&#39;s . Even after<br>&gt; stopping the service it is still returned by service discovery done<br>&gt; from another device. I would like to know where is the registry of
<br>&gt; these services maintained by bluez library.&nbsp;&nbsp;Also how can I modify<br>&gt; this services registry ?<br><br>if the service record doesn&#39;t disappear, then your code is wrong. You<br>have used persistent SDP records. Don&#39;t do that. And it is even better
<br>to register the service records over D-Bus.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
<br></blockquote></div><br><br clear="all"><br>-- <br>Tushar Paturde

------=_Part_60915_1895042.1176782547704--


--===============1889084489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1889084489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1889084489==--
