Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b621074b0704162102u3100c63ax15be998c472ecf3f@mail.gmail.com>
References: <b621074b0704160159pc7e4f6l65e849875d0ab676@mail.gmail.com>
	<1176727272.30165.2.camel@aeonflux.holtmann.net>
	<b621074b0704162102u3100c63ax15be998c472ecf3f@mail.gmail.com>
Date: Thu, 19 Apr 2007 01:45:36 +0200
Message-Id: <1176939936.6741.39.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Tushar,

> The code snippet  that I'm using for registering  new service record
> is as below .
> 
> #define BT_INVALID_SDDB_HANDLE 0
> ....
> bt_result_t bt_sddb_update_record(bt_record_t *record) 
> {
>     int scanned;
>     sdp_record_t *rec = sdp_extract_pdu((uint8_t *)record->data,
> &scanned);
>     if (rec == NULL) {
>         return BT_RESULT_FAILURE;
>     }
> 
>     if (record->id == BT_INVALID_SDDB_HANDLE) { 
>         if (sdp_record_register(g_sess, rec, 0) < 0) {
>             sdp_record_free(rec);
>             return BT_RESULT_FAILURE;
>         }
>         record->id = (bt_sddbid_t)rec->handle;
>         return BT_RESULT_SUCCESS;
>     } else {
>         int retval;
>         rec->handle = record->id;
>         retval = sdp_record_update(g_sess, rec);
>         sdp_record_free(rec);
>         if (retval < 0) { 
>             return BT_RESULT_FAILURE;
>         }
>         record->id = (bt_sddbid_t)rec->handle;
>         return BT_RESULT_SUCCESS;
>     }
> }
> 
> 
> 
> In this code sdp_record_register return with success but the   value
> of "rec->handle " is set to zero (0).  This is problem for me. I think
> the value should be greater than zero or ideally 1. Because the "
> record" that is passed with service information has set it's handle to
> zero i.e it point to the default service record.  
> 
> This is causes problem in the upper layer of java implementation . So
> I need to kill the app manually at present. But it seems
> "sdp_record_register" operation is success because the registered
> service can be  browsed by external device. 

I don't see your problem, but you might really consider to use the D-Bus
based service record registration. You can even use XML based service
record description.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
