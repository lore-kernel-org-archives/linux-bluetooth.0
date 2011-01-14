Return-Path: <cyrus@holtmann.org>
Message-ID: <4D305D77.5060102@nokia.com>
Date: Fri, 14 Jan 2011 16:28:07 +0200
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: =?UTF-8?B?ZXh0IFPFgmF3b21pciBCb2NoZcWEc2tp?=
	<slawomir.bochenski@comarch.com>,
	Bartosz Szatkowski <bulislaw@linux.com>
Subject: Proposed interface for Message Access Profile
Content-Type: multipart/mixed;
 boundary="------------070602070302050803080800"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070602070302050803080800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Hi!
In the attachment is proposed header with interface for BT MAP plugin 
for obexd.

Please let me know your comments.


BR,
Radek

--------------070602070302050803080800
Content-Type: text/x-chdr;
 name="messages.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="messages.h"

/*
 *
 *  Message Access Protocol transport plugin  
 *
 *  Copyright (C) 2010-2011  Slawomir Bochenski <lkslawek@gmail.com>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

/* Tags needed to retrieve and set application parameters */
#define MAXLISTCOUNT_TAG	0x01
#define STARTOFFSET_TAG		0x02
#define FILTERMESSAGETYPE_TAG	0x03
#define FILTERPERIODBEGIN_TAG	0x04
#define FILTERPERIODEND_TAG	0x05
#define FILTERREADSTATUS_TAG	0x06
#define FILTERRECIPIENT_TAG	0x07
#define FILTERORIGINATOR_TAG	0x08
#define FILTERPRIORITY_TAG	0x09
#define ATTACHMENT_TAG		0x0A
#define TRANSPARENT_TAG		0x0B
#define RETRY_TAG		0x0C
#define NEWMESSAGE_TAG		0x0D
#define NOTIFICATIONSTATUS_TAG	0x0E
#define MASINSTANCEID_TAG	0x0F
#define PARAMETERMASK_TAG	0x10
#define FOLDERLISTINGSIZE_TAG	0x11
#define MESSAGESLISTINGSIZE_TAG	0x12
#define SUBJECTLENGTH_TAG	0x13
#define CHARSET_TAG		0x14
#define FRACTIONREQUEST_TAG	0x15
#define FRACTIONDELIVER_TAG	0x16
#define STATUSINDICATOR_TAG	0x17
#define STATUSVALUE_TAG		0x18
#define MSETIME_TAG		0x19

/* Those are used by backend to notify transport plugin which properties did it
 * send
 */
#define PMASK_SUBJECT			0x0001
#define PMASK_DATETIME			0x0002
#define PMASK_SENDER_NAME		0x0004
#define PMASK_SENDER_ADDRESSING		0x0008
#define PMASK_RECIPIENT_NAME		0x0010
#define PMASK_RECIPIENT_ADDRESSING	0x0020
#define PMASK_TYPE			0x0040
#define PMASK_SIZE			0x0080
#define PMASK_RECEPTION_STATUS		0x0100
#define PMASK_TEXT			0x0200
#define PMASK_ATTACHMENT_SIZE		0x0400
#define PMASK_PRIORITY			0x0800
#define PMASK_READ			0x1000
#define PMASK_SENT			0x2000
#define PMASK_PROTECTED			0x4000
#define PMASK_REPLYTO_ADDRESSING	0x8000

/* This one is used in a response to GetFolderListing. Specification does not
 * say anything about required attributes and name is the only one required by
 * OBEX DTD for folder-listing. We can also consider size, modified, created and
 * accessed.
 */
struct folder_entry {
	char *name;
};

/* This one is used in a response to GetMessagesListing. Use PMASK_* values to
 * notify the plugin which members are actually set. Backend shall not ommit
 * properties required by MAP specification (subject, datetime,
 * recipient_addressing, type, size, reception_status, attachment_size) unless
 * ordered by PARAMETERMASK. Boolean values should be probably
 * always send (need checking). Handle is mandatory. Plugin will filter out any
 * properties that were not wanted by MCE.
 *
 * Handle shall be set to hexadecimal representation with upper-case letters. No
 * prefix shall be appended and without leading zeros. This corresponds to PTS
 * behaviour described in comments to the MAP specification.
 *
 * The rest of char * fields shall be set according to the MAP specification
 * rules.
 */
struct message_data {
	uint32_t mask;
	char *handle;
	char *subject;
	char *datetime;
	char *sender_name;
	char *sender_addressing;
	char *replyto_addressing;
	char *recipient_name;
	char *recipient_addressing;
	char *type;			/* XXX: or enum? */
	char *reception_status;		/* XXX: or enum? */
	char *size;			/* XXX: int? */
	char *attachment_size;		/* XXX: int? */
	gboolean text;
	gboolean read;
	gboolean sent;
	gboolean protect;
	gboolean priority;
};

/* Type of message event to be delivered to MNS server */
enum message_event_type {
	MET_NEW_MESSAGE,
	MET_DELIVERY_SUCCESS,
	MET_SENDING_SUCCESS,
	MET_DELIVERY_FAILURE,
	MET_SENDING_FAILURE,
	MET_MEMORY_FULL,
	MET_MEMORY_AVAILABLE,
	MET_MESSAGE_DELETED,
	MET_MESSAGE_SHIFT
};

/* Data for sending MNS notification. Handle shall be formatted as described in
 * message_data.
 */
struct message_event_data {
	enum message_event_type type;
	uint8_t instance_id;
	char *handle;
	char *folder;
	char *old_folder;
	char *msg_type;		/* XXX: enum */
};

/* TODO: This will be changed */
void messages_event(struct message_event_data *data);

/* As MAP uses application parameter extensively and actions can change based on
 * whether selected parameter was send or not, plugin offers simple access
 * functions to those parameters.
 */

/* Replaces value of or adds specified parameter. val should point to variable
 * of appropriate type. If val is NULL, removes specified parameter.
 */
gboolean aparams_write(GHashTable *params, int tag, gpointer val);

/* Reads value of specified parameter. val should be NULL or point to variable
 * of appropriate type. Returns TRUE if parameter is present. If not, then
 * it returns FALSE and does not change value pointed by val.
 */
gboolean aparams_read(GHashTable *params, int tag, gpointer val);

/* See messages_open() below */
enum messages_function_id {
	MFID_INVALID = 0,
	MFID_SET_NOTIFICATION_REGISTRATION,
	MFID_GET_FOLDER_LISTING,
	MFID_GET_MESSAGES_LISTING,
	MFID_GET_MESSAGE,
	MFID_SET_MESSAGE_STATUS,
	MFID_PUSH_MESSAGE,
	MFID_UPDATE_INBOX,
};

/* Called on session connect.
 *
 * If session start succeeded, backend shall return non-NULL value. This value
 * will be passed in all other calls to backend.
 *
 * This allows backend to keep track of sessions. It is needed because read
 * property changes scope shall be session-limited.
 */
void *messages_connect(int *err);

/* Called on session disconnect.
 *
 * This call should free buffer reserved by messages_connect.
 */
void messages_disconnect(void *context);

/* INTERFACE: Callback used for GetMessage, GetMessagesListing and
 * GetFolderListing. fid and user_data shall be set to those from messages_open
 * call.
 *
 * data:
 *	GetMessage: const char *body
 *		Fragment of message body. Backend has the responsibility of
 *		building proper x-bt/message object.
 *	GetMessagesListing: const struct message_data *md
 *		Single entry of message listing.
 *	GetFolderListing: const struct folder_entry *f
 *		Single entry of folder listing.
 *
 * Set err to -EINTR if you don't want transport to start transfer immediately.
 * This is especially required if you plan to set outparams -> those will be
 * sent only once per request the first time err == 0. If err != 0 && err !=
 * -EINTR, request is aborted and response is set accordingly.
 */
typedef void (*messages_cb)
	(void *user_data, void *data, int err);

/* INTERFACE: this is called once after server starts */
int messages_init(void);

/* INTERFACE: this is called once before server finishes */
void messages_exit(void);

/* inparams
 *	application parameters received in the request. Use aparams_read() to
 *	access.
 * outparams
 *	application parameters to send back in the response. Build with
 *	aparams_write().
 * callback
 *	currently only for GetMessage, GetMessagesListing, GetFolderListing.
 *	Backend must call it from asynchronous event for example by using
 *	g_idle_add_full.
 * name
 *	as delivered by client. Can be NULL.
 */
struct mas_request {
	enum messages_function_id fid;
	GHashTable *inparams;
	GHashTable *outparams;
	messages_cb callback; // XXX: removeme
	const char *name;
};

/* Called on all GETs/PUTs. Requested function is in data->fid. Functions for
 * which data->callback is set must use asynchronous mode. Other functions shall
 * be completed in this call.
 *
 * user_data shall be passed in each callback call.
 *
 * Return 0 if immediate function succeded or callbacks for asynchronous one
 * will follow. If return value < 0 then OBEX error will be set accordlingly and
 * no further processing of session will follow.
 */
int messages_open(void *context, struct mas_request *data,
					void *user_data);


/* Called always after finished request (also when ABORTed) */
int messages_close(void *context);

/* INTERFACE: sets new folder (see MAP specification for flags) */
int messages_setpath(void *session, const char *name, uint8_t flags);

--------------070602070302050803080800--
