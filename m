Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4278F2BC.4080104@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] sdptool
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 04 May 2005 18:05:16 +0200

Hi!

I am following the code of sdptool.c and I have a question. I am 
comparing add_sp() and add_opush() and I have found something that 
puzzles me. The first part of the code is almost the same, but there are 
some sdp_list_free() calls in add_opush() that are present in add_sp(). 
For example:

static int add_sp(sdp_session_t *session, svc_info_t *si)
{
    /* ... */
    sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
    svclass_id = sdp_list_append(0, &sp_uuid);
    sdp_set_service_classes(&record, svclass_id);
    sdp_list_free(svclass_id, 0);
    /* ... */
}

static int add_opush(sdp_session_t *session, svc_info_t *si)
{
    /* ... */
    sdp_uuid16_create(&opush_uuid, OBEX_OBJPUSH_SVCLASS_ID);
    svclass_id = sdp_list_append(0, &opush_uuid);
    sdp_set_service_classes(&record, svclass_id);
    /* ... */
}

Is this correct? Shouldn't there be a call to sdp_list_free(svclass_id, 
0) in add_opush() too? As I understand it, this means that add_opush() 
has a memory leak, isn't it? I have found at least three missing calls 
to sdp_list_free() in add_opush().

Regards,

Pedro Monjo


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
