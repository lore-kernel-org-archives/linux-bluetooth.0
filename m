Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050324143846.43236.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: adding sdp service record attributes
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1521229110-1111675126=:42230"
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
Date: Thu, 24 Mar 2005 22:38:46 +0800 (CST)

--0-1521229110-1111675126=:42230
Content-Type: multipart/alternative; boundary="0-1730111954-1111675126=:42230"

--0-1730111954-1111675126=:42230
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
    Maybe I state the problem again here. At past, I connected my T610 from my PC by typing "rfcomm connect 0 <address>", and then run my main program, and the program can continue. But when I changed from connecting T610 to PC, even though I can connect T610 to PC, the "/dev/rfcomm0: no such device" message is shown. I know that I have to type "mknod /dev/rfcomm0 c 216 0", and it was successful in the first approach: PC to T610, but not vice versa. So, I wish to know why is that. I attach files for you to look why is that. It is a note that bic_sdp.c and bic_sdp.h are included in /usr/include folder and the other two are main programs, one contains the part from cmd_listen function in rfcomm/main.c and the other one is not. Thank you very much for your kindness.
Michael

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> P.S. bic_michael.c and bic_rfcomm.c are main programs without and with
> the part from rfcomm/main.c respectively, and bic_sdp.c and bic_sdp.h
> are files to be included in /usr/include

actually I miss the GPL statement and a comment about the origin for
parts of your code at the top of these files.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content. Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users





---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1730111954-1111675126=:42230
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>
<DIV>Hi Marcel!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Maybe I state the problem again here. At past, I connected my T610 from my PC by typing "rfcomm connect 0 &lt;address&gt;", and then run my main program, and the program can continue. But when I changed from connecting T610 to PC, even though I can connect T610 to PC, the "/dev/rfcomm0: no such device" message is shown. I know that I have to type "mknod&nbsp;/dev/rfcomm0 c 216 0", and it was successful in the first approach: PC to T610, but not vice versa. So, I wish to know why is that. I attach&nbsp;files for you to look why is that. It is a note that bic_sdp.c and bic_sdp.h are included in /usr/include folder and the other two are&nbsp;main programs, one contains the part from cmd_listen function in rfcomm/main.c and the other one is not. Thank you very much for your kindness.</DIV>
<DIV>Michael<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; P.S. bic_michael.c and bic_rfcomm.c are main programs without and with<BR>&gt; the part from rfcomm/main.c respectively, and bic_sdp.c and bic_sdp.h<BR>&gt; are files to be included in /usr/include<BR><BR>actually I miss the GPL statement and a comment about the origin for<BR>parts of your code at the top of these files.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.net email is sponsored by Microsoft Mobile &amp; Embedded DevCon 2005<BR>Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows<BR>Embedded(r) &amp; Windows Mobile(tm) platforms, applications &amp; content. Register<BR>by 3/29 &amp; save $300 http://ads.osdn.com/?ad_id=6883&amp;alloc_id=15149&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE></DIV></DIV><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1730111954-1111675126=:42230--

--0-1521229110-1111675126=:42230
Content-Type: text/plain; name="bic_michael_test.c"
Content-Description: bic_michael_test.c
Content-Disposition: inline; filename="bic_michael_test.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <malloc.h>
#include <string.h>
#include <getopt.h>
#include <signal.h>
#include <errno.h>
#include <sys/poll.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <termios.h>
#include <syslog.h>

#include <modeminit.h>
#include <modeminit.c>
#include <logging.c>
#include <logging.h>
#include <extras.h>
#include <extras.c>
#include <locking.c>
#include <locking.h>
#include <alarm.h>
#include <alarm.c>

#include <bic_sdp.c>
#include <bic_sdp.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <bluetooth/rfcomm.h>

#include <sys/file.h>

#include <mysql/mysql.h>

char filename[500] = { 0 };
char logfile[256] = { 0 };
char alarmhandler[256] = { 0 };
int alarmlevel = LOG_WARNING;
int loglevel = 9;
int ret_code;
char tmp[100];
char command[1024];//used for AT command only for creating menu
char buffer[1024];//used for AT command only when the number of choice1 is dynamic
char answer[1024];//used for the command for the Linux PC
char type[3];
char remote[20];
char *target, *user, *password;

MYSQL mysql;
MYSQL_RES *result;
MYSQL_ROW row;

void TVcontrol(char remote[]);
void CDcontrol(char remote[]);
void VCDcontrol(char remote[]);
void DVDcontrol(char remote[]);
void VCRcontrol(char remote[]);
void projectorcontrol(char remote[]);

void devicecontrol(MYSQL *, char [], char []);

void parsearguments1()
{
	strcpy (device, "/dev/null");
	baudrate = 115200;
	errorsleeptime = 10;
	rtscts = 0;
	strcpy (modemname, device);
	}

void parsearguments ()
{
	strcpy (device, "/dev/rfcomm0");
	baudrate = 115200;
	errorsleeptime = 10;
	rtscts = 0;
	strcpy (modemname, device);
	}

void flush (char *fl,int len)
{
	int m;
	for (m=0;m<len;m++)
	{
		fl[m]='\0';
		}
	}

int main (int argc, char **argv)
{
	int submenu_selected;
	int ans_selected[7];
	int a,b;
	int choice;
    	int count;
	int sock, client;
	socklen_t alen;
	struct sockaddr_rc addr;
	int which_submenu;
	int type_selected;
	target=user=password=NULL;
	profile T610profile;
    	svc_info_t T610svc;
	bdaddr_t bdaddr;
	//char *str="00:0A:D9:DD:D8:A8";
    	//estr2ba(str, &bdaddr);
	sdp_session_t *sess;
	printf("\E[H\E[J"); 
	printf ("Bluetooth infrared converter\n\n");
	printf ("Doing initializations !\n");
	//T610profile.handle=0x10001;
	//T610profile.attrib=0x100;
        //T610profile.attri_value="0x1108";
	printf("T610 profile is added\n");
	T610svc.class=0x1108;
	printf("Service name is added\n");
    	T610svc.profile=0x1108;
	T610svc.channel=3;
    	T610svc.name="HS";
	add_service(T610profile.bdaddr, &T610svc);
	//printf("Now attribute will be set\n");
	sess = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
	//set_attrib(sess, T610profile.handle, T610profile.attrib, T610profile.attri_value);
   	//printf("attributes are set\n");
	mysql_init(&mysql);
	if (!mysql_connect(&mysql, target, user, password)) 
	{
       	printf("Database connection failed\n");
       	return 0;
   		}
	else 
		printf("Database connection ok\n");  
	mysql_select_db(&mysql,"AVDevice");
	system("hciconfig hci0 class 0x200404");
	while (1)
	{
		addr.rc_family = AF_BLUETOOTH;
		bacpy(&addr.rc_bdaddr, BDADDR_ANY);
		addr.rc_channel = 3;
		alen = sizeof(addr);
		// request a socket from the operating system
		if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
		{
			printf("socket(...) failed");
			exit(1);
			}
		// bind the socket to the system
		if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
		{
			printf("bind(...) failed\n");
			exit(2);
			}
		// set the socket into listen mode. handle 10 (QUEUE) connections.
		if(listen(sock, 10) < 0)
		{
			printf("listen(...) failed\n");
			exit(3);
			}
		// wait for the next connection or serve the next in the queue
		while(client = accept(sock, (struct sockaddr *)&addr, &alen))
		{
			char remoteAddr[18];
			ba2str(&addr.rc_bdaddr, remoteAddr);
			printf("connection from %s:\n", remoteAddr);
			parsearguments ();
			snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)", modemname);
			tmp[sizeof (tmp) - 1] = 0;
			openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
			set_alarmhandler (alarmhandler, alarmlevel, modemname);
			openmodem ();
			setmodemparams ();
			sprintf (command, "at+cscs=i\"8859-1\"\r");
			ret_code = put_command (command, answer, sizeof (answer), 5, 0);
			sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");
			ret_code = put_command (command, answer, sizeof (answer), 5, 0);
			printf("Now T610 is connected to the PC\n");
			while (1)
			{
				submenu_selected = 0;
				while (!submenu_selected)
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					submenu_selected = (NULL != strstr (answer, "*EAAI"));
					}
				while (1)
				{
					sprintf (command, "AT*EASM=\"Bt-IrConverter\",1,1,7,\"TV\",\"CD\",\"VCD\",\"DVD\",\"VCR\",\"Projector\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 7, 0);
					for (a=0; a<7; a++)
						ans_selected[a]=0;
					count=1;
					while (count)
					{
						ret_code = put_command ("", answer, sizeof (answer), 5, 0);
						for (b=0; b<7; b++)
						{
							sprintf (buffer, "*EAMI: %d", b+1);
							ans_selected[b] = (NULL != strstr (answer, buffer));
							if (ans_selected[b]==1)
							{
								count=0;
								type_selected=b+1;
								break;
								}
							}
						}
					if (ans_selected[6])
						break;
	      				else if (ans_selected[0])
						printf("Mobile user selected TV\n"); 
					else if (ans_selected[1])
						printf("Mobile user selected CD\n"); 
	      				else if (ans_selected[2])
						printf("Mobile user selected VCD\n");
					else if (ans_selected[3])
						printf("Mobile user selected DVD\n");
					else if (ans_selected[4])
						printf("Mobile user selected VCR\n");
					else if (ans_selected[5])
						printf("Mobile user selected Projector\n");
					switch (type_selected)
					{
						case 1:
							devicecontrol(&mysql, "TV", remote);
							break;
						case 2:	
							devicecontrol(&mysql, "CD", remote);
							break;
						case 3:
							devicecontrol(&mysql, "VCD", remote);
							break;
						case 4:
							devicecontrol(&mysql, "DVD", remote);
							break;
						case 5:
							devicecontrol(&mysql, "VCR", remote);
							break;
						case 6:
							devicecontrol(&mysql, "Projector", remote);
							break;
						default:
							break;
						}
					}
				}
			mysql_close(&mysql);
			printf ("Mobile user has quitted!\n");
			//exit(0); 
			sprintf(command, "AT+CMER=0,0,0,0,0\r");
			ret_code = put_command (command, answer, sizeof (answer), 5, 0);   
			}
		// now close the connection
		close(client);
        }
	close(sock);
}
--0-1521229110-1111675126=:42230
Content-Type: text/plain; name="bic_sdp.c"
Content-Description: bic_sdp.c
Content-Disposition: inline; filename="bic_sdp.c"

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <getopt.h>
#include <netinet/in.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

#include "bic_sdp.h"

static int estr2ba(char *str, bdaddr_t *ba)
{
	if(!strcmp(str, "local")) {
		bacpy(ba, BDADDR_LOCAL);
		return 0;
	}
	return str2ba(str, ba);
}

static void sdp_uuid_printf(uuid_t *uuid, struct attrib_context *context, int indent)
{
	if (uuid) {
		if (uuid->type == SDP_UUID16) {
			uint16_t uuidNum = uuid->value.uuid16;
			struct uuid_def *uuidDef = NULL;
			int i;
			for (i = 0; i < uuid16_max; i++)
				if (uuid16_names[i].num == uuidNum) {
					uuidDef = &uuid16_names[i];
					break;
				}
			if (context->attrib && context->attrib->num == SERVICE_ATTR) {
				context->service = uuidDef;
			}
			if (uuidDef)
				printf("%.*sUUID16 : 0x%.4x - %s\n",
					indent, indent_spaces, uuidNum, uuidDef->name);
			else
				printf("%.*sUUID16 : 0x%.4x\n",
					indent, indent_spaces, uuidNum);
		} else if (uuid->type == SDP_UUID32) {
			struct uuid_def *uuidDef = NULL;
			int i;
			if (!(uuid->value.uuid32 & 0xffff0000)) {
				uint16_t uuidNum = uuid->value.uuid32;
				for (i = 0; i < uuid16_max; i++)
					if (uuid16_names[i].num == uuidNum) {
						uuidDef = &uuid16_names[i];
						break;
					}
			}
			if (uuidDef)
				printf("%.*sUUID32 : 0x%.8x - %s\n",
					indent, indent_spaces, uuid->value.uuid32, uuidDef->name);
			else
				printf("%.*sUUID32 : 0x%.8x\n",
					indent, indent_spaces, uuid->value.uuid32);
		} else if (uuid->type == SDP_UUID128) {
			unsigned int data0;
			unsigned short data1;
			unsigned short data2;
			unsigned short data3;
			unsigned int data4;
			unsigned short data5;
			memcpy(&data0, &uuid->value.uuid128.data[0], 4);
			memcpy(&data1, &uuid->value.uuid128.data[4], 2);
			memcpy(&data2, &uuid->value.uuid128.data[6], 2);
			memcpy(&data3, &uuid->value.uuid128.data[8], 2);
			memcpy(&data4, &uuid->value.uuid128.data[10], 4);
			memcpy(&data5, &uuid->value.uuid128.data[14], 2);
			printf("%.*sUUID128 : 0x%.8x-%.4x-%.4x-%.4x-%.8x-%.4x\n",
				indent, indent_spaces,
				ntohl(data0), ntohs(data1), ntohs(data2),
				ntohs(data3), ntohl(data4), ntohs(data5));
		} else
			printf("%.*sEnum type of UUID not set\n",
				indent, indent_spaces);
	} else
		printf("%.*sNull passed to print UUID\n",
				indent, indent_spaces);
}

static void printf_dataseq(sdp_data_t * pData, struct attrib_context *context, int indent)
{
	sdp_data_t *sdpdata = NULL;

	sdpdata = pData;
	if (sdpdata) {
		context->member_index = 0;
		do {
			sdp_data_printf(sdpdata, context, indent + 2);
			sdpdata = sdpdata->next;
			context->member_index++;
		} while (sdpdata);
	} else {
		printf("%.*sBroken dataseq link\n", indent, indent_spaces);
	}
}

static void sdp_data_printf(sdp_data_t *sdpdata, struct attrib_context *context, int indent)
{
	char *member_name = NULL;
	if (context->attrib && context->attrib->members &&
	   context->member_index < context->attrib->member_max) {
	  member_name = context->attrib->members[context->member_index].name;
	}
	switch (sdpdata->dtd) {
	case SDP_DATA_NIL:
		printf("%.*sNil\n", indent, indent_spaces);
		break;
	case SDP_BOOL:
	case SDP_UINT8:
	case SDP_UINT16:
	case SDP_UINT32:
	case SDP_UINT64:
	case SDP_UINT128:
	case SDP_INT8:
	case SDP_INT16:
	case SDP_INT32:
	case SDP_INT64:
	case SDP_INT128:
		if (member_name) {
			printf("%.*s%s (Integer) : 0x%x\n",
				indent, indent_spaces, member_name, sdpdata->val.uint32);
		} else {
			printf("%.*sInteger : 0x%x\n", indent, indent_spaces,
				sdpdata->val.uint32);
		}
		break;
	case SDP_UUID16:
	case SDP_UUID32:
	case SDP_UUID128:
		sdp_uuid_printf(&sdpdata->val.uuid, context, indent);
		break;
	case SDP_TEXT_STR8:
	case SDP_TEXT_STR16:
	case SDP_TEXT_STR32:
		if (sdpdata->unitSize > strlen(sdpdata->val.str)) {
			int i;
			printf("%.*sData :", indent, indent_spaces);
			for (i = 0; i < sdpdata->unitSize; i++)
				printf(" %02x", (unsigned char) sdpdata->val.str[i]);
			printf("\n");
		} else 
			printf("%.*sText : \"%s\"\n", indent, indent_spaces, sdpdata->val.str);
 		break;
	case SDP_URL_STR8:
	case SDP_URL_STR16:
	case SDP_URL_STR32:
		printf("%.*sURL : %s\n", indent, indent_spaces, sdpdata->val.str);

		break;

	case SDP_SEQ8:
	case SDP_SEQ16:
	case SDP_SEQ32:
		printf("%.*sData Sequence\n", indent, indent_spaces);
		printf_dataseq(sdpdata->val.dataseq, context, indent);
		break;

	case SDP_ALT8:
	case SDP_ALT16:
	case SDP_ALT32:
		printf("%.*sData Sequence Alternates\n", indent, indent_spaces);
		printf_dataseq(sdpdata->val.dataseq, context, indent);
		break;
	}
}

static void sdp_attr_printf_func(void *value, void *userData)
{
	sdp_data_t *sdpdata = NULL;
	uint16_t attrId;
	struct service_context *service = (struct service_context *) userData;
	struct attrib_context context;
	struct attrib_def *attrDef = NULL;
	int i;
	sdpdata = (sdp_data_t *)value;
	attrId = sdpdata->attrId;
	for (i = 0; i < attrib_max; i++)
		if (attrib_names[i].num == attrId) {
			attrDef = &attrib_names[i];
			break;
		}
	if ((attrDef == NULL) && (service->service != NULL) &&
				(service->service->attribs != NULL)) {
		struct attrib_def *svc_attribs = service->service->attribs;
		int		svc_attrib_max = service->service->attrib_max;
		for (i = 0; i < svc_attrib_max; i++)
			if (svc_attribs[i].num == attrId) {
				attrDef = &svc_attribs[i];
				break;
			}
	}
	if (attrDef)
		printf("Attribute Identifier : 0x%x - %s\n", attrId, attrDef->name);
	else
		printf("Attribute Identifier : 0x%x\n", attrId);
	context.service = service->service;
	context.attrib = attrDef;
	context.member_index = 0;
	if (sdpdata)
		sdp_data_printf(sdpdata, &context, 2);
	else
		printf("  NULL value\n");
	service->service = context.service;
}

static void sdp_printf_service_attr(sdp_record_t *rec)
{
	if (rec && rec->attrlist) {
		struct service_context service = { NULL };
		sdp_list_foreach(rec->attrlist, sdp_attr_printf_func, &service);
	}
}

static int set_attrib(sdp_session_t *sess, uint32_t handle, uint16_t attrib, char *value) 
{
	sdp_list_t *attrid_list;
	uint32_t range = 0x0000ffff;
	sdp_record_t *rec;
	attrid_list = sdp_list_append(NULL, &range);
	rec = sdp_service_attr_req(sess, handle, SDP_ATTR_REQ_RANGE, attrid_list);
	printf("Now we are setting attribute\n");
	if (!rec) {
		printf("Service get request failed.\n");
		return -1;
	}
	if (!strncasecmp(value, "u0x", 3)) {
		uint16_t value_int = 0;
		uuid_t value_uuid;
		value_int = strtoul(value + 3, NULL, 16);
		sdp_uuid16_create(&value_uuid, value_int);
		printf("Adding attrib 0x%X uuid16 0x%X to record 0x%X\n",
			attrib, value_int, handle);
		sdp_attr_add_new(rec, attrib, SDP_UUID16, &value_uuid.value.uuid16);
	} else if (!strncasecmp(value, "0x", 2)) {
		uint32_t value_int;  
		value_int = strtoul(value + 2, NULL, 16);
		printf("Adding attrib 0x%X int 0x%X to record 0x%X\n",
			attrib, value_int, handle);
		sdp_attr_add_new(rec, attrib, SDP_UINT32, &value_int);
	} else {
		printf("Adding attrib 0x%X string \"%s\" to record 0x%X\n",
			attrib, value, handle);
		sdp_attr_add_new(rec, attrib, SDP_TEXT_STR8, value);
	}
	if (sdp_record_update(sess, rec)) {
		printf("Service Record update failed (%d).\n", errno);
		return -1;
	}
	return 0;
}

static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attrib, int argc, char **argv)
{
	sdp_list_t *attrid_list;
	uint32_t range = 0x0000ffff;
	sdp_record_t *rec;
	sdp_data_t *pSequenceHolder = NULL;
	void **dtdArray;
	void **valueArray;
	void **allocArray;
	uint8_t uuid16 = SDP_UUID16;
	uint8_t uint32 = SDP_UINT32;
	uint8_t str8 = SDP_TEXT_STR8;
	int i;
	attrid_list = sdp_list_append(NULL, &range);
	rec = sdp_service_attr_req(session, handle, SDP_ATTR_REQ_RANGE, attrid_list);

	if (!rec) {
		printf("Service get request failed.\n");
		return -1;
	}
	dtdArray = (void **)malloc(argc * sizeof(void *));
	valueArray = (void **)malloc(argc * sizeof(void *));
	allocArray = (void **)malloc(argc * sizeof(void *));
	for (i = 0; i < argc; i++) {
		if (!strncasecmp(argv[i], "u0x", 3)) {
			uint16_t value_int = strtoul((argv[i]) + 3, NULL, 16);
			uuid_t *value_uuid = (uuid_t *)malloc(sizeof(uuid_t));
			allocArray[i] = value_uuid;
			sdp_uuid16_create(value_uuid, value_int);

			printf("Adding uuid16 0x%X to record 0x%X\n", value_int, handle);
			dtdArray[i] = &uuid16;
			valueArray[i] = &value_uuid->value.uuid16;
		} else if (!strncasecmp(argv[i], "0x", 2)) {
			uint32_t *value_int = (int *)malloc(sizeof(int));
			allocArray[i] = value_int;
			*value_int = strtoul((argv[i]) + 2, NULL, 16);
			printf("Adding int 0x%X to record 0x%X\n", *value_int, handle);
			dtdArray[i] = &uint32;
			valueArray[i] = value_int;
		} else {
			printf("Adding string \"%s\" to record 0x%X\n", argv[i], handle);
			dtdArray[i] = &str8;
			valueArray[i] = argv[i];
		}
	}
	pSequenceHolder = sdp_seq_alloc(dtdArray, valueArray, argc);
	if (pSequenceHolder) {
		sdp_attr_replace(rec, attrib, pSequenceHolder);
		if (sdp_record_update(session, rec)) {
			printf("Service Record update failed (%d).\n", errno);
			return -1;
		}
	} else {
		printf("Failed to create pSequenceHolder\n");
	}
	for (i = 0; i < argc; i++)
		free(allocArray[i]);
	free(dtdArray);
	free(valueArray);

	return 0;
}

static void print_service_class(void *value, void *userData)
{
	char ServiceClassUUID_str[MAX_LEN_SERVICECLASS_UUID_STR];
	uuid_t *uuid = (uuid_t *)value;

	sdp_uuid2strn(uuid, UUID_str, MAX_LEN_UUID_STR);
	sdp_svclass_uuid2strn(uuid, ServiceClassUUID_str, MAX_LEN_SERVICECLASS_UUID_STR);
	printf("  \"%s\" (0x%s)\n", ServiceClassUUID_str, UUID_str);
}

static void print_service_desc(void *value, void *user)
{
	char str[MAX_LEN_PROTOCOL_UUID_STR];
	sdp_data_t *p = (sdp_data_t *)value, *s;
	int i = 0, proto = 0;
	
	for (; p; p = p->next, i++) {
		switch (p->dtd) {
		case SDP_UUID16:
		case SDP_UUID32:
		case SDP_UUID128:
			sdp_uuid2strn(&p->val.uuid, UUID_str, MAX_LEN_UUID_STR);
			sdp_proto_uuid2strn(&p->val.uuid, str, sizeof(str));
			proto = sdp_uuid_to_proto(&p->val.uuid);
			printf("  \"%s\" (0x%s)\n", str, UUID_str);
			break;
		case SDP_UINT8:
			if (proto == RFCOMM_UUID)
				printf("    Channel: %d\n", p->val.uint8);
			else
				printf("    uint8: 0x%x\n", p->val.uint8);
			break;
		case SDP_UINT16:
			if (proto == L2CAP_UUID) {
				if (i == 1)
					printf("    PSM: %d\n", p->val.uint16);
				else
					printf("    Version: 0x%04x\n", p->val.uint16);
			} else if (proto == BNEP_UUID)
				if (i == 1)
					printf("    Version: 0x%04x\n", p->val.uint16);
				else
					printf("    uint16: 0x%x\n", p->val.uint16);
			else
				printf("    uint16: 0x%x\n", p->val.uint16);
			break;
		case SDP_SEQ16:
			printf("    SEQ16:");
			for (s = p->val.dataseq; s; s = s->next)
				printf(" %x", s->val.uint16);
			printf("\n");
			break;
		case SDP_SEQ8:
			printf("    SEQ8:");
			for (s = p->val.dataseq; s; s = s->next)
				printf(" %x", s->val.uint8);
			printf("\n");
			break;
		default:
			printf("    FIXME: dtd=0%x\n", p->dtd);
			break;
		}
	}
}

static void print_lang_attr(void *value, void *user)
{
	sdp_lang_attr_t *lang = (sdp_lang_attr_t *)value;
	printf("  code_ISO639: 0x%02x\n", lang->code_ISO639);
	printf("  encoding:    0x%02x\n", lang->encoding);
	printf("  base_offset: 0x%02x\n", lang->base_offset);
}

static void print_access_protos(void *value, void *userData)
{
	sdp_list_t *protDescSeq = (sdp_list_t *)value;
	sdp_list_foreach(protDescSeq, print_service_desc, 0);
}

static void print_profile_desc(void *value, void *userData)
{
	sdp_profile_desc_t *desc = (sdp_profile_desc_t *)value;
	char str[MAX_LEN_PROFILEDESCRIPTOR_UUID_STR];

	sdp_uuid2strn(&desc->uuid, UUID_str, MAX_LEN_UUID_STR);
	sdp_profile_uuid2strn(&desc->uuid, str, MAX_LEN_PROFILEDESCRIPTOR_UUID_STR);

	printf("  \"%s\" (0x%s)\n", str, UUID_str);
	if (desc->version)
		printf("    Version: 0x%04x\n", desc->version);
}

static void print_service_attr(sdp_record_t *rec)
{
	sdp_list_t *list = 0, *proto = 0;

	sdp_record_print(rec);

	printf("Service RecHandle: 0x%x\n", rec->handle);

	if (sdp_get_service_classes(rec, &list) == 0) {
		printf("Service Class ID List:\n");
		sdp_list_foreach(list, print_service_class, 0);
		sdp_list_free(list, free);
	}
	if (sdp_get_access_protos(rec, &proto) == 0) {
		printf("Protocol Descriptor List:\n");
		sdp_list_foreach(proto, print_access_protos, 0);
		sdp_list_free(proto, (sdp_free_func_t)sdp_data_free);
	}
	if (sdp_get_lang_attr(rec, &list) == 0) {
		printf("Language Base Attr List:\n");
		sdp_list_foreach(list, print_lang_attr, 0);
		sdp_list_free(list, free);
	}
	if (sdp_get_profile_descs(rec, &list) == 0) {
		printf("Profile Descriptor List:\n");
		sdp_list_foreach(list, print_profile_desc, 0);
		sdp_list_free(list, free);
	}
}

typedef struct {
	char *name;
	char *provider;
	char *desc;
	
	unsigned int class;
	unsigned int profile;
	unsigned int channel;
} svc_info_t;

static int add_sp(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
	uuid_t root_uuid, sp_uuid, l2cap, rfcomm;
        sdp_record_t record;
	sdp_profile_desc_t profile;
	uint8_t u8 = si->channel? si->channel: 1;
	sdp_data_t *channel;
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);
	sdp_list_free(root, 0);

	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &sp_uuid);
	sdp_set_service_classes(&record, svclass_id);
	sdp_list_free(svclass_id, 0);

	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
	profile.version = 0x0100;
	profiles = sdp_list_append(0, &profile);
	sdp_set_profile_descs(&record, profiles);
	sdp_list_free(profiles, 0);

	sdp_uuid16_create(&l2cap, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	sdp_set_info_attr(&record, "Serial Port", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("Serial Port service registered\n");
	printf("Service name: %s \n", si->name);
	printf("Service provider: %s \n", si->provider);
	printf("Service desc: %s \n", si->desc);
	printf("Service class: %d \n", si->class);
	printf("Service profile: %d \n", si->profile);
	printf("Service channel: %d \n", si->channel);
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

static int add_headset(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
	sdp_record_t record;
	sdp_profile_desc_t profile;
	sdp_list_t *aproto, *proto[2];
	uint8_t u8 = si->channel? si->channel: 5;
	sdp_data_t *channel;
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&svclass_uuid, HEADSET_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &svclass_uuid);
	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
	profile.version = 0x0100;
	pfseq = sdp_list_append(0, &profile);
	sdp_set_profile_descs(&record, pfseq);

	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap_uuid);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm_uuid);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	sdp_set_info_attr(&record, "Headset", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("Headset service registered\n");
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

static int add_handsfree(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
        sdp_record_t record;	
	sdp_profile_desc_t profile;
	sdp_list_t *aproto, *proto[2];
	uint8_t u8 = si->channel? si->channel: 3;
	uint16_t u16 = 0x31;
	sdp_data_t *channel, *features;	
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &svclass_uuid);
	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
	profile.version = 0x0101;
	pfseq = sdp_list_append(0, &profile);
	sdp_set_profile_descs(&record, pfseq);

	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap_uuid);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm_uuid);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	features = sdp_data_alloc(SDP_UINT16, &u16);
	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	sdp_set_info_attr(&record, "Handsfree", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("Handsfree service registered\n");
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

static int add_simaccess(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
        sdp_record_t record;	
	sdp_profile_desc_t profile;
	sdp_list_t *aproto, *proto[2];
	uint8_t u8 = si->channel? si->channel: 3;
	uint16_t u16 = 0x31;
	sdp_data_t *channel, *features;	
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&svclass_uuid, SAP_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &svclass_uuid);
	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&profile.uuid, SAP_PROFILE_ID);
	profile.version = 0x0101;
	pfseq = sdp_list_append(0, &profile);
	sdp_set_profile_descs(&record, pfseq);

	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap_uuid);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm_uuid);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	features = sdp_data_alloc(SDP_UINT16, &u16);
	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	sdp_set_info_attr(&record, "SIM Access", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("Handsfree service registered\n");
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

static int add_opush(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
	uuid_t root_uuid, opush_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
	sdp_profile_desc_t profile[1];
	sdp_list_t *aproto, *proto[3];
	sdp_record_t record;
	uint8_t chan = si->channel? si->channel: 4;
	sdp_data_t *channel;
	uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06 };
	//uint8_t formats[] = { 0xff };
	void *dtds[sizeof(formats)], *values[sizeof(formats)];
	int i;
	uint8_t dtd = SDP_UINT8;
	sdp_data_t *sflist;
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&opush_uuid, OBEX_OBJPUSH_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &opush_uuid);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
	profile[0].version = 0x0100;
	pfseq = sdp_list_append(0, profile);
	sdp_set_profile_descs(&record, pfseq);

	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap_uuid);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm_uuid);
	channel = sdp_data_alloc(SDP_UINT8, &chan);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
	proto[2] = sdp_list_append(0, &obex_uuid);
	apseq = sdp_list_append(apseq, proto[2]);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	for (i = 0; i < sizeof(formats); i++) {
		dtds[i] = &dtd;
		values[i] = &formats[i];
	}
	sflist = sdp_seq_alloc(dtds, values, sizeof(formats));
	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FORMATS_LIST, sflist);

	sdp_set_info_attr(&record, "OBEX Object Push", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("OBEX Object Push service registered\n");
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(proto[2], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

static int add_file_trans(sdp_session_t *session, svc_info_t *si)
{
	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
	uuid_t root_uuid, ftrn_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
	sdp_profile_desc_t profile[1];
	sdp_list_t *aproto, *proto[3];
	sdp_record_t record;
	uint8_t u8 = si->channel? si->channel: 4;
	sdp_data_t *channel;
	int ret = 0;

	memset((void *)&record, 0, sizeof(sdp_record_t));
	record.handle = 0xffffffff;
	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(&record, root);

	sdp_uuid16_create(&ftrn_uuid, OBEX_FILETRANS_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &ftrn_uuid);
	sdp_set_service_classes(&record, svclass_id);

	sdp_uuid16_create(&profile[0].uuid, OBEX_FILETRANS_PROFILE_ID);
	profile[0].version = 0x0100;
	pfseq = sdp_list_append(0, &profile[0]);
	sdp_set_profile_descs(&record, pfseq);

	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap_uuid);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm_uuid);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
	proto[2] = sdp_list_append(0, &obex_uuid);
	apseq = sdp_list_append(apseq, proto[2]);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(&record, aproto);

	sdp_set_info_attr(&record, "OBEX File Transfer", 0, 0);

	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
		printf("Service Record registration failed\n");
		ret = -1;
		goto end;
	}
	printf("OBEX File Transfer service registered\n");
end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(proto[2], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	return ret;
}

struct {
	char		*name;
	uint16_t	class;
	int		(*add)(sdp_session_t *sess, svc_info_t *si);
} service[] = {
	{ "SP",		SERIAL_PORT_SVCLASS_ID,		add_sp		},
	{ "OPUSH",	OBEX_OBJPUSH_SVCLASS_ID,	add_opush	},
	{ "FTRN",	OBEX_FILETRANS_SVCLASS_ID,	add_file_trans	},
	{ "HS",		HEADSET_SVCLASS_ID,		add_headset	},
	{ "HF",		HANDSFREE_SVCLASS_ID,		add_handsfree	},
	{ "SAP",	SAP_SVCLASS_ID,			add_simaccess	},
	{ 0 }
};


static int add_service(bdaddr_t *bdaddr, svc_info_t *si)
{
	int i;
	sdp_session_t *sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);

	if (!sess)
		return -1;
	if (si->name)
		for (i = 0; service[i].name; i++)
			if (!strcasecmp(service[i].name, si->name)) {
				int ret = -1;
				if (service[i].add)
					ret = service[i].add(sess, si);
                                printf("sdp service is added\n");
                                //free(si->name);
				sdp_close(sess);
				return ret;
			}
	printf("Unknown service name: %s\n", si->name);
	free(si->name);
	sdp_close(sess);
	return -1;
}



--0-1521229110-1111675126=:42230
Content-Type: text/plain; name="bic_sdp.h"
Content-Description: bic_sdp.h
Content-Disposition: inline; filename="bic_sdp.h"

#ifndef BIC_SDP_H
#define BIC_SDP_H

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <getopt.h>
#include <netinet/in.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

#define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, 0)) != -1)

static int estr2ba(char *str, bdaddr_t *ba);

struct search_context {
	char		*svc;		/* Service */
	uuid_t		group;		/* Browse group */
	int		tree;		/* Display full attribute tree */
	uint32_t	handle;		/* Service record handle */
};

typedef int (*handler_t)(bdaddr_t *bdaddr, struct search_context *arg);

static char UUID_str[MAX_LEN_UUID_STR];
static bdaddr_t interface;

struct member_def {
	char *name;
};

struct attrib_def {
	int			num;		/* Numeric ID - 16 bits */
	char			*name;		/* User readable name */
	struct member_def	*members;	/* Definition of attribute args */
	int			member_max;	/* Max of attribute arg definitions */
};

struct uuid_def {
	int			num;		/* Numeric ID - 16 bits */
	char			*name;		/* User readable name */
	struct attrib_def	*attribs;	/* Specific attribute definitions */
	int			attrib_max;	/* Max of attribute definitions */
};

struct attrib_context {
	struct uuid_def		*service;	/* Service UUID, if known */
	struct attrib_def	*attrib;	/* Description of the attribute */
	int			member_index;	/* Index of current attribute member */
};

struct service_context {
	struct uuid_def		*service;	/* Service UUID, if known */
};

static char *indent_spaces = "                                         ";

#define SERVICE_ATTR	0x1

static struct member_def protocol_members[] = {
	{ "Protocol"		},
	{ "Channel/Port"	},
	{ "Version"		},
};

static struct member_def profile_members[] = {
	{ "Profile"	},
	{ "Version"	},
};

static struct member_def language_members[] = {
	{ "Code ISO639"		},
	{ "Encoding"		},
	{ "Base Offset"		},
};

static struct attrib_def attrib_names[] = {
	{ 0x0, "ServiceRecordHandle", NULL, 0 },
	{ 0x1, "ServiceClassIDList", NULL, 0 },
	{ 0x2, "ServiceRecordState", NULL, 0 },
	{ 0x3, "ServiceID", NULL, 0 },
	{ 0x4, "ProtocolDescriptorList",
		protocol_members, sizeof(protocol_members)/sizeof(struct member_def) },
	{ 0x5, "BrowseGroupList", NULL, 0 },
	{ 0x6, "LanguageBaseAttributeIDList",
		language_members, sizeof(language_members)/sizeof(struct member_def) },
	{ 0x7, "ServiceInfoTimeToLive", NULL, 0 },
	{ 0x8, "ServiceAvailability", NULL, 0 },
	{ 0x9, "BluetoothProfileDescriptorList",
		profile_members, sizeof(profile_members)/sizeof(struct member_def) },
	{ 0xA, "DocumentationURL", NULL, 0 },
	{ 0xB, "ClientExecutableURL", NULL, 0 },
	{ 0xC, "IconURL", NULL, 0 },
	{ 0xD, "AdditionalProtocolDescriptorLists", NULL, 0 },
};

const int attrib_max = sizeof(attrib_names)/sizeof(struct attrib_def);

static struct attrib_def sdp_attrib_names[] = {
	{ 0x200, "VersionNumberList", NULL, 0 },
	{ 0x201, "ServiceDatabaseState", NULL, 0 },
};

static struct attrib_def browse_attrib_names[] = {
	{ 0x200, "GroupID", NULL, 0 },
};

static struct attrib_def did_attrib_names[] = {
	{ 0x200, "SpecificationID", NULL, 0 },
	{ 0x201, "VendorID", NULL, 0 },
	{ 0x202, "ProductID", NULL, 0 },
	{ 0x203, "Version", NULL, 0 },
	{ 0x204, "PrimaryRecord", NULL, 0 },
	{ 0x205, "VendorIDSource", NULL, 0 },
};

static struct attrib_def hid_attrib_names[] = {
	{ 0x200, "DeviceReleaseNum", NULL, 0 },
	{ 0x201, "ParserVersion", NULL, 0 },
	{ 0x202, "DeviceSubclass", NULL, 0 },
	{ 0x203, "CountryCode", NULL, 0 },
	{ 0x204, "VirtualCable", NULL, 0 },
	{ 0x205, "ReconnectInitiate", NULL, 0 },
	{ 0x206, "DescriptorList", NULL, 0 },
	{ 0x207, "LangIDBaseList", NULL, 0 },
	{ 0x208, "SDPDisable", NULL, 0 },
	{ 0x209, "BatteryPower", NULL, 0 },
	{ 0x20a, "RemoteWakeup", NULL, 0 },
	{ 0x20b, "ProfileVersion", NULL, 0 },
	{ 0x20c, "SupervisionTimeout", NULL, 0 },
	{ 0x20d, "NormallyConnectable", NULL, 0 },
	{ 0x20e, "BootDevice", NULL, 0 },
};

static struct attrib_def pan_attrib_names[] = {
	{ 0x200, "IpSubnet", NULL, 0 },		
	{ 0x30A, "SecurityDescription", NULL, 0 },
	{ 0x30B, "NetAccessType", NULL, 0 },
	{ 0x30C, "MaxNetAccessrate", NULL, 0 },
	{ 0x30D, "IPv4Subnet", NULL, 0 },
	{ 0x30E, "IPv6Subnet", NULL, 0 },
};

static struct attrib_def audio_attrib_names[] = {
	{ 0x302, "Remote audio volume control", NULL, 0 },
};

static struct uuid_def uuid16_names[] = {
	{ 0x0001, "SDP (Service Discovery Protocol)", NULL, 0 },
	{ 0x0002, "UDP", NULL, 0 },
	{ 0x0003, "RFCOMM", NULL, 0 },
	{ 0x0004, "TCP", NULL, 0 },
	{ 0x0005, "TCS-BIN", NULL, 0 },
	{ 0x0006, "TCS-AT", NULL, 0 },
	{ 0x0008, "OBEX", NULL, 0 },
	{ 0x0009, "IP", NULL, 0 },
	{ 0x000a, "FTP", NULL, 0 },
	{ 0x000c, "HTTP", NULL, 0 },
	{ 0x000e, "WSP", NULL, 0 },
	{ 0x000f, "BNEP (PAN/BNEP)", NULL, 0 },
	{ 0x0010, "UPnP/ESDP", NULL, 0 },
	{ 0x0011, "HIDP", NULL, 0 },
	{ 0x0012, "HardcopyControlChannel", NULL, 0 },
	{ 0x0014, "HardcopyDataChannel", NULL, 0 },
	{ 0x0016, "HardcopyNotification", NULL, 0 },
	{ 0x0017, "AVCTP", NULL, 0 },
	{ 0x0019, "AVDTP", NULL, 0 },
	{ 0x001b, "CMTP", NULL, 0 },
	{ 0x001d, "UDI_C-Plane", NULL, 0 },
	{ 0x0100, "L2CAP", NULL, 0 },
	{ 0x1000, "ServiceDiscoveryServerServiceClassID (SDP)",
		sdp_attrib_names, sizeof(sdp_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1001, "BrowseGroupDescriptorServiceClassID (SDP)",
		browse_attrib_names, sizeof(browse_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1002, "PublicBrowseGroup (SDP)", NULL, 0 },
	{ 0x1101, "SerialPort", NULL, 0 },
	{ 0x1102, "LANAccessUsingPPP", NULL, 0 },
	{ 0x1103, "DialupNetworking (DUN)", NULL, 0 },
	{ 0x1104, "IrMCSync", NULL, 0 },
	{ 0x1105, "OBEXObjectPush", NULL, 0 },
	{ 0x1106, "OBEXFileTransfer", NULL, 0 },
	{ 0x1107, "IrMCSyncCommand", NULL, 0 },
	{ 0x1108, "Headset",
		audio_attrib_names, sizeof(audio_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1109, "CordlessTelephony", NULL, 0 },
	{ 0x110a, "AudioSource", NULL, 0 },
	{ 0x110b, "AudioSink", NULL, 0 },
	{ 0x110c, "RemoteControlTarget", NULL, 0 },
	{ 0x110d, "AdvancedAudio", NULL, 0 },
	{ 0x110e, "RemoteControl", NULL, 0 },
	{ 0x110f, "VideoConferencing", NULL, 0 },
	{ 0x1110, "Intercom", NULL, 0 },
	{ 0x1111, "Fax", NULL, 0 },
	{ 0x1112, "HeadsetAudioGateway", NULL, 0 },
	{ 0x1113, "WAP", NULL, 0 },
	{ 0x1114, "WAP Client", NULL, 0 },
	{ 0x1115, "PANU (PAN/BNEP)",
		pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1116, "NAP (PAN/BNEP)",
		pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1117, "GN (PAN/BNEP)",
		pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1118, "DirectPrinting (BPP)", NULL, 0 },
	{ 0x1119, "ReferencePrinting (BPP)", NULL, 0 },
	{ 0x111e, "Handsfree", NULL, 0 },
	{ 0x111f, "HandsfreeAudioGateway", NULL, 0 },
	{ 0x1120, "DirectPrintingReferenceObjectsService (BPP)", NULL, 0 },
	{ 0x1121, "ReflectedUI (BPP)", NULL, 0 },
	{ 0x1122, "BasicPrinting (BPP)", NULL, 0 },
	{ 0x1123, "PrintingStatus (BPP)", NULL, 0 },
	{ 0x1124, "HumanInterfaceDeviceService (HID)",
		hid_attrib_names, sizeof(hid_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1125, "HardcopyCableReplacement (HCR)", NULL, 0 },
	{ 0x1126, "HCR_Print (HCR)", NULL, 0 },
	{ 0x1127, "HCR_Scan (HCR)", NULL, 0 },
	{ 0x1128, "Common ISDN Access (CIP)", NULL, 0 },
	{ 0x1129, "VideoConferencingGW (VCP)", NULL, 0 },
	{ 0x112d, "SIM Access (SAP)", NULL, 0 },
	{ 0x1200, "PnPInformation",
		did_attrib_names, sizeof(did_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1201, "GenericNetworking", NULL, 0 },
	{ 0x1202, "GenericFileTransfer", NULL, 0 },
	{ 0x1203, "GenericAudio",
		audio_attrib_names, sizeof(audio_attrib_names)/sizeof(struct attrib_def) },
	{ 0x1204, "GenericTelephony", NULL, 0 },
};

static const int uuid16_max = sizeof(uuid16_names)/sizeof(struct uuid_def);

static void sdp_data_printf(sdp_data_t *, struct attrib_context *, int);

static void sdp_uuid_printf(uuid_t *uuid, struct attrib_context *context, int indent);

static void printf_dataseq(sdp_data_t * pData, struct attrib_context *context, int indent);

static void sdp_data_printf(sdp_data_t *sdpdata, struct attrib_context *context, int indent);

static void sdp_attr_printf_func(void *value, void *userData);

static void sdp_printf_service_attr(sdp_record_t *rec);

static int set_attrib(sdp_session_t *sess, uint32_t handle, uint16_t attrib, char *value); 

static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attrib, int argc, char **argv);

static void print_service_class(void *value, void *userData);

static void print_service_desc(void *value, void *user);

static void print_lang_attr(void *value, void *user);

static void print_access_protos(void *value, void *userData);

static void print_profile_desc(void *value, void *userData);

static void print_service_attr(sdp_record_t *rec);


typedef struct {
		bdaddr_t *bdaddr;
		uint32_t handle;
		uint16_t attrib;
		char *attri_value;
} profile;

#endif

--0-1521229110-1111675126=:42230
Content-Type: text/plain; name="bic_rfcomm_test.c"
Content-Description: bic_rfcomm_test.c
Content-Disposition: inline; filename="bic_rfcomm_test.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <malloc.h>
#include <string.h>
#include <getopt.h>
#include <signal.h>
#include <errno.h>
#include <sys/poll.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <termios.h>
#include <syslog.h>

#include <modeminit.h>
#include <modeminit.c>
#include <logging.c>
#include <logging.h>
#include <extras.h>
#include <extras.c>
#include <locking.c>
#include <locking.h>
#include <alarm.h>
#include <alarm.c>

#include <bic_sdp.c>
#include <bic_sdp.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <bluetooth/rfcomm.h>

#include <sys/file.h>

#include <mysql/mysql.h>

char filename[500] = { 0 };
char logfile[256] = { 0 };
char alarmhandler[256] = { 0 };
int alarmlevel = LOG_WARNING;
int loglevel = 9;
int ret_code;
char tmp[100];
char command[1024];//used for AT command only for creating menu
char buffer[1024];//used for AT command only when the number of choice1 is dynamic
char answer[1024];//used for the command for the Linux PC
char type[3];
char remote[20];
char *target, *user, *password;

MYSQL mysql;
MYSQL_RES *result;
MYSQL_ROW row;

void TVcontrol(char remote[]);
void CDcontrol(char remote[]);
void VCDcontrol(char remote[]);
void DVDcontrol(char remote[]);
void VCRcontrol(char remote[]);
void projectorcontrol(char remote[]);

void devicecontrol(MYSQL *, char [], char []);

void parsearguments1()
{
	strcpy (device, "/dev/null");
	baudrate = 115200;
	errorsleeptime = 10;
	rtscts = 0;
	strcpy (modemname, device);
	}

void parsearguments ()
{
	strcpy (device, "/dev/rfcomm0");
	baudrate = 115200;
	errorsleeptime = 10;
	rtscts = 0;
	strcpy (modemname, device);
	}

void flush (char *fl,int len)
{
	int m;
	for (m=0;m<len;m++)
	{
		fl[m]='\0';
		}
	}

int main (int argc, char **argv)
{
	int submenu_selected;
	int ans_selected[7];
	int a,b;
	int choice;
    	int count;
	int ctl;
	int dev;
	int which_submenu;
	int type_selected;
	int sock;
	int client;
	static int rfcomm_raw_tty = 0;
	struct sockaddr_rc laddr, raddr;
	struct rfcomm_dev_req req;
	struct termios ti;
	struct sigaction sa;
	struct pollfd p;
	char dst[18], devname[MAXPATHLEN];
	int sk, nsk, fd, alen, try = 3;
	target=user=password=NULL;
	profile T610profile;
    	svc_info_t T610svc;
	bdaddr_t bdaddr;
    	//char *str="00:0A:D9:DD:D8:A8";
    	//estr2ba(str, &bdaddr);
	sdp_session_t *sess;
	printf("\E[H\E[J"); 
	printf ("Bluetooth infrared converter\n\n");
	printf ("Doing initializations !\n");
	//T610profile.handle=0x10001;
	//T610profile.attrib=0x100;
    	//T610profile.attri_value="0x1108";
	printf("T610 profile is added\n");
	T610svc.class=0x1108;
	printf("Service name is added\n");
    	T610svc.profile=0x1108;
	T610svc.channel=3;
    	T610svc.name="HS";
	add_service(T610profile.bdaddr, &T610svc);
	//printf("Now attribute will be set\n");
	sess = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
	//set_attrib(sess, T610profile.handle, T610profile.attrib, T610profile.attri_value);
   	//printf("attributes are set\n");
	mysql_init(&mysql);
	if (!mysql_connect(&mysql, target, user, password)) 
	{
       	printf("Database connection failed\n");
       	return 0;
   		}
	else 
		printf("Database connection ok\n");  
	mysql_select_db(&mysql,"AVDevice");
	system("hciconfig hci0 class 0x200404");
	while (1)
	{
	  /*The following part is from rfcomm/main.c*/
		laddr.rc_family = AF_BLUETOOTH;
		bacpy(&laddr.rc_bdaddr, &bdaddr);
		laddr.rc_channel =3;
		if((sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM))< 0) 
		{
			perror("Can't create RFCOMM socket");
			return;
			}
		if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) 
		  {
			perror("Can't bind RFCOMM socket");
			close(sk);
			return;
			}
		printf("Waiting for connection on channel %d\n", laddr.rc_channel);
		listen(sk, 10);
		alen = sizeof(raddr);
		nsk = accept(sk, (struct sockaddr *) &raddr, &alen);
		alen = sizeof(laddr);
		if (getsockname(nsk, (struct sockaddr *)&laddr, &alen) < 0) {
			perror("Can't get RFCOMM socket name");
			close(nsk);
			return;
			}
		memset(&req, 0, sizeof(req));
		req.dev_id = dev;
		req.flags = (1 << RFCOMM_REUSE_DLC) | (1 << RFCOMM_RELEASE_ONHUP);
		bacpy(&req.src, &laddr.rc_bdaddr);
		bacpy(&req.dst, &raddr.rc_bdaddr);
		req.channel = raddr.rc_channel;
		if ((dev = ioctl(nsk, RFCOMMCREATEDEV, &req)) < 0) {
			perror("Can't create RFCOMM TTY");
			close(sk);
			return;
			}
		snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
		while ((fd = open(devname, O_RDONLY | O_NOCTTY)) < 0) 
		  {
			snprintf(devname, MAXPATHLEN - 1, "/dev/bluetooth/rfcomm/%d", dev);
			if ((fd = open(devname, O_RDONLY | O_NOCTTY)) < 0) 
			  {
			    if (try--) 
			      {
				snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
				sleep(1);
				continue;
				}
			perror("Can't open RFCOMM device");
			memset(&req, 0, sizeof(req));
			req.dev_id = dev;
			req.flags = (1 << RFCOMM_HANGUP_NOW);
			ioctl(ctl, RFCOMMRELEASEDEV, &req);
			close(sk);
			return;
			}
		}
		if (rfcomm_raw_tty) {
			tcflush(fd, TCIOFLUSH);
			cfmakeraw(&ti);
			tcsetattr(fd, TCSANOW, &ti);
			}
		close(sk);
		close(nsk);
		ba2str(&req.dst, dst);
		printf("Connection from %s to %s\n", dst, devname);
		/*The part from rfcomm/main.c ends*/
		parsearguments ();
		snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)", modemname);
		tmp[sizeof (tmp) - 1] = 0;
		openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
		set_alarmhandler (alarmhandler, alarmlevel, modemname);
		openmodem ();
		setmodemparams ();
		sprintf (command, "at+cscs=i\"8859-1\"\r");
		ret_code = put_command (command, answer, sizeof (answer), 5, 0);
		sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");
		ret_code = put_command (command, answer, sizeof (answer), 5, 0);
		printf("Now T610 is connected to the PC\n");
		while (1)
		{
			submenu_selected = 0;
			while (!submenu_selected)
			{
				ret_code = put_command ("", answer, sizeof (answer), 5, 0);
				submenu_selected = (NULL != strstr (answer, "*EAAI"));
				}
			while (1)
			{
				sprintf (command, "AT*EASM=\"Bt-IrConverter\",1,1,7,\"TV\",\"CD\",\"VCD\",\"DVD\",\"VCR\",\"Projector\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 7, 0);
				for (a=0; a<7; a++)
					ans_selected[a]=0;
				count=1;
				while (count)
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					for (b=0; b<7; b++)
					{
						sprintf (buffer, "*EAMI: %d", b+1);
						ans_selected[b] = (NULL != strstr (answer, buffer));
						if (ans_selected[b]==1)
						{
							count=0;
							type_selected=b+1;
							break;
							}
						}
					}
				if (ans_selected[6])
					break;
	      			else if (ans_selected[0])
					printf("Mobile user selected TV\n"); 
				else if (ans_selected[1])
					printf("Mobile user selected CD\n"); 
	      			else if (ans_selected[2])
					printf("Mobile user selected VCD\n");
				else if (ans_selected[3])
					printf("Mobile user selected DVD\n");
				else if (ans_selected[4])
					printf("Mobile user selected VCR\n");
				else if (ans_selected[5])
					printf("Mobile user selected Projector\n");
				switch (type_selected)
				{
					case 1:
						devicecontrol(&mysql, "TV", remote);
						break;
					case 2:	
						devicecontrol(&mysql, "CD", remote);
						break;
					case 3:
						devicecontrol(&mysql, "VCD", remote);
						break;
					case 4:
						devicecontrol(&mysql, "DVD", remote);
						break;
					case 5:
						devicecontrol(&mysql, "VCR", remote);
						break;
					case 6:
						devicecontrol(&mysql, "Projector", remote);
						break;
					default:
						break;
					}
				}
			mysql_close(&mysql);
			printf ("Mobile user has quitted!\n");
			//exit(0); 
			sprintf(command, "AT+CMER=0,0,0,0,0\r");
			ret_code = put_command (command, answer, sizeof (answer), 5, 0);   
			}
		// now close the connection
		close(client);
        }
	close(sock);
}
--0-1521229110-1111675126=:42230--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
