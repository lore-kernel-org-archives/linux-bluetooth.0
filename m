Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601261344h6114915cw9872353c27d3910f@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [gbluezconf] D-Bus client prototype
In-Reply-To: <1138309764.5901.153.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13751_804754.1138311898984"
References: <e1effdeb0512201427g43906c29g78a8ce4fcdc3c71a@mail.gmail.com>
	 <1135120979.26233.40.camel@localhost>
	 <e1effdeb0512211051i63f7e734jac900d5fd9ab70ca@mail.gmail.com>
	 <1135192627.25328.8.camel@localhost>
	 <e1effdeb0601261259h7eb14f95wc315f53a2c0baa14@mail.gmail.com>
	 <1138309764.5901.153.camel@localhost>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 26 Jan 2006 19:44:58 -0200

------=_Part_13751_804754.1138311898984
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Use this attached file for now.
I will fix it in the next prototype.


Regards,
Claudio



On 1/26/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > A new prototype version is available at:
> > http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.04.tar.gz
>
> you still depend on a "bluetooth/dbus.h" file that is not part of BlueZ
> yet. Why don't you include a copy of it?
>
> The error looks like this:
>
> pair.c:41:28: error: bluetooth/dbus.h: No such file or directory
> pair.c: In function '_dbus_pair_hci_signal_filter_cb':
> pair.c:516: error: 'DEV_HCI_INTERFACE' undeclared (first use in this func=
tion)
> pair.c:516: error: (Each undeclared identifier is reported only once
> pair.c:516: error: for each function it appears in.)
> ...
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_13751_804754.1138311898984
Content-Type: text/x-chdr; name=dbus.h; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus.h"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
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

#define __END_SIG__ DBUS_TYPE_INVALID_AS_STRING

#define BASE_PATH		"/org/bluez"
#define BASE_INTERFACE		"org.bluez"

#define DEVICE_PATH		BASE_PATH "/Device"
#define DEVICE_INTERFACE	BASE_INTERFACE ".Device"

#define MANAGER_PATH		BASE_PATH "/Manager"
#define MANAGER_INTERFACE	BASE_INTERFACE ".Manager"

#define ERROR_INTERFACE		BASE_INTERFACE ".Error"

#define MANAGER_PATH_MASK	(1 << 15)
#define DEVICE_PATH_MASK	(1 << 14)

/* /org/bluez/Manager */
#define MANAGER_ROOT_ID		MANAGER_PATH_MASK

/* /org/bluez/Device */
#define DEVICE_ROOT_ID		DEVICE_PATH_MASK

/* E.g. /org/bluez/Device/hci0 */
#define DEVICE_PATH_ID		(DEVICE_PATH_MASK | 0x0001)

/* E.g. /org/bluez/Device/hci0/Controller */
#define HCI_PATH_ID		(DEVICE_PATH_MASK | 0x0002)

#define INVALID_PATH_ID		0xFFFF
#define INVALID_DEV_ID		0xFFFF

/*======================================================================== 
    BlueZ D-Bus Manager service definitions "/org/bluez/Manager"
 *========================================================================*/

#define MGR_DEVICE_LIST		"DeviceList"
#define MGR_DEFAULT_DEVICE	"DefaultDevice"
#define MGR_INIT		"Init"

/* Enable/Disable services controller, pan, serial, ... */
#define MGR_ENABLE		"Enable"
#define MGR_DISABLE		"Disable"

/* Signatures */

#define MGR_GET_DEV_SIGNATURE			__END_SIG__

/* DeviceList Reply: a(devname, addr, type, up/down, a(flags)) - all types strings */
#define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING \
						DEV_GET_DEV_REPLY_STRUCT_SIGNATURE \
						__END_SIG__

#define MGR_GET_DEV_REPLY_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_ARRAY_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						DBUS_STRUCT_END_CHAR_AS_STRING \
						__END_SIG__

#define MGR_DEFAULT_DEV_SIGNATURE		__END_SIG__


/* Signals sent in the Manager path */
#define BLUEZ_MGR_DEV_ADDED		"DeviceAdded"
#define BLUEZ_MGR_DEV_REMOVED		"DeviceRemoved"


/*======================================================================== 
    BlueZ D-Bus Device path definitions "/org/bluez/Device"
 *========================================================================*/

/* Interfaces implemented in the "/org/bluez/Device" path */
#define BLUEZ_HCI			"Controller"
#define DEV_HCI_INTERFACE		DEVICE_INTERFACE "." BLUEZ_HCI

/* Control interface signals */
#define BLUEZ_HCI_INQ_START		"InquiryStart"
#define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
#define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
#define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
#define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
#define BLUEZ_HCI_AUTH_COMPLETE		"AuthenticationComplete"
#define BLUEZ_HCI_DISCONN_COMPLETE      "DisconnectionComplete"

/* Control interface methods */
#define HCI_PERIODIC_INQ		"PeriodicInquiry"
#define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
#define HCI_INQ				"Inquiry"
#define HCI_CANCEL_INQ			"CancelInquiry"
#define HCI_ROLE_SWITCH			"RoleSwitch"
#define HCI_REMOTE_NAME			"RemoteName"
#define HCI_CONNECTIONS			"Connections"
#define HCI_AUTHENTICATE		"Authenticate"

/* Control interface methods */
#define DEV_UP				"Up"
#define DEV_DOWN			"Down"
#define DEV_SET_PROPERTY		"SetProperty"
#define DEV_GET_PROPERTY		"GetProperty"

#define DEV_PROPERTY_AUTH		"auth"
#define DEV_PROPERTY_ENCRYPT		"encrypt"
#define DEV_PROPERTY_SECMGR		"secmgr"
#define DEV_PROPERTY_PISCAN		"piscan"
#define DEV_PROPERTY_PSCAN		"pscan"
#define DEV_PROPERTY_ISCAN		"iscan"
#define DEV_PROPERTY_PTYPE		"ptype"
#define DEV_PROPERTY_LM			"lm"
#define DEV_PROPERTY_LP			"lp"
#define DEV_PROPERTY_NAME		"name"
#define DEV_PROPERTY_CLASS		"class"
#define DEV_PROPERTY_VOICE		"voice"
#define DEV_PROPERTY_IAC		"iac"
#define DEV_PROPERTY_INCMODE		"incmode"
#define DEV_PROPERTY_INCTYPE		"inctype"
#define DEV_PROPERTY_INCPARMS		"incparms"
#define DEV_PROPERTY_PAGEPARMS		"pageparms"
#define DEV_PROPERTY_PAGETO		"pageto"
#define DEV_PROPERTY_AFHMODE		"afhmode"
#define DEV_PROPERTY_ACLMTU		"aclmtu"
#define DEV_PROPERTY_SCOMTU		"scomtu"
#define DEV_PROPERTY_PUTKEY		"putkey"
#define DEV_PROPERTY_DELKEY		"delkey"
#define DEV_PROPERTY_DEV_INFO		"info"

#define DEV_UP_SIGNATURE			__END_SIG__
#define DEV_DOWN_SIGNATURE			__END_SIG__
#define DEV_RESET_SIGNATURE			__END_SIG__
#define DEV_SET_PROPERTY_SIGNATURE_1		DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_BOOLEAN_AS_STRING \
						__END_SIG__
#define DEV_SET_PROPERTY_SIGNATURE_2		DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_STRING_AS_STRING \
						__END_SIG__
#define DEV_SET_PROPERTY_SIGNATURE_3		DBUS_TYPE_STRING_AS_STRING \
						DBUS_TYPE_UINT16_AS_STRING \
						__END_SIG__

#define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
						__END_SIG__

#define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							__END_SIG__

#define HCI_PERIODIC_INQ_EXT_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_TYPE_UINT32_AS_STRING \
							__END_SIG__

#define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__

#define HCI_INQ_SIGNATURE				__END_SIG__

#define HCI_INQ_EXT_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
							DBUS_TYPE_UINT32_AS_STRING \
							__END_SIG__

#define HCI_CANCEL_INQ_SIGNATURE			__END_SIG__

#define HCI_ROLE_SWITCH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
							DBUS_TYPE_BYTE_AS_STRING \
							__END_SIG__

#define HCI_REMOTE_NAME_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
							__END_SIG__

#define HCI_CONNECTIONS_SIGNATURE			__END_SIG__

#define HCI_CONN_INFO_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_TYPE_STRING_AS_STRING \
							DBUS_TYPE_BYTE_AS_STRING \
							DBUS_TYPE_BYTE_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_TYPE_UINT32_AS_STRING \
							DBUS_STRUCT_END_CHAR_AS_STRING \
							__END_SIG__

#define HCI_DEVICE_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
							DBUS_TYPE_STRING_AS_STRING \
							DBUS_TYPE_STRING_AS_STRING \
							DBUS_STRUCT_END_CHAR_AS_STRING \
							__END_SIG__

#define HCI_INQ_REPLY_SIGNATURE				DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
							DBUS_TYPE_STRING_AS_STRING \
							DBUS_TYPE_UINT32_AS_STRING \
							DBUS_TYPE_UINT16_AS_STRING \
							DBUS_STRUCT_END_CHAR_AS_STRING \
							__END_SIG__

#define HCI_AUTHENTICATE_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
							__END_SIG__


/* BLUEZ_DBUS_ERROR 
 * EFailed error messages signature is : su
 * Where the first argument is a string(error message description),
 * the last  is a uint32 that contains the error class(system, dbus or hci). */

/* Error code offsets */
#define BLUEZ_EBT_OFFSET		(0x00000000) /* see Bluetooth error code */
#define BLUEZ_EBT_EXT_OFFSET		(0x00000100)
#define BLUEZ_EDBUS_OFFSET		(0x00010000)
#define BLUEZ_ESYSTEM_OFFSET		(0x00020000)
#define BLUEZ_EFUTURE_OFFSET		(0x00040000)

/* D-Bus error code, class BLUEZ_EDBUS_OFFSET */
#define BLUEZ_EDBUS_UNKNOWN_METHOD	(0x01 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_WRONG_SIGNATURE	(0x02 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_WRONG_PARAM		(0x03 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_RECORD_NOT_FOUND	(0x04 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_NO_MEM   		(0x05 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 + BLUEZ_EDBUS_OFFSET)
#define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 + BLUEZ_EDBUS_OFFSET)

/* D-Bus error code, class BLUEZ_ESYSTEM_OFFSET */
#define BLUEZ_ESYSTEM_ENODEV		(ENODEV + BLUEZ_ESYSTEM_OFFSET)

/* BLUEZ_DBUS_ERR_NO_MEMORY */
#define BLUEZ_DBUS_ERR_NO_MEMORY_STR	"No memory"


------=_Part_13751_804754.1138311898984--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
