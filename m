Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050323134226.4082.qmail@web60901.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: adding sdp service record attributes
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1102683115-1111585346=:2667"
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
Date: Wed, 23 Mar 2005 21:42:26 +0800 (CST)

--0-1102683115-1111585346=:2667
Content-Type: multipart/alternative; boundary="0-209686432-1111585346=:2667"

--0-209686432-1111585346=:2667
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Andreas!
    Thank you very much for your email. Actually, I can connect the phone to PC now. But the new problem arises. Last time I did the things i.e. adding sdp headset profile, setting the class of my PC to be headset and then setting the channel in SDP and hciconfig, separately. Now, I wish to integrate these three separate jobs into my project's main program. The procedure is as that stated above. Then I put the part of socket programming in my main program, and this part can be said to come from rfcomm/main.c's cmd_listen function. But when my phone can connect to PC, the terminal shows "dev/rfcomm0: no such device". Then, I don't preset the address of my phone, but then when the phone can connect to PC, the following ios shown: "Can't create rfcomm TTY socket: too many open files in the system" or "dev/rfcomm0: connection refused". There is a note that in order to continue my program, the modem should be opened successfully, and the menu should be sent to my phine successfull
 y. So, I
 wish to know what's wrong about my program, and how I can fix it. I attach the programs here for you, and hope that other users, can find it out. Thank you very much for your kindness.
P.S. bic_michael.c and bic_rfcomm.c are main programs without and with the part from rfcomm/main.c respectively, and bic_sdp.c and bic_sdp.h are files to be included in /usr/include
Michael 

Andreas <andreas.knuth@daimlerchrysler.com> wrote:
Ka Kin Cheung yahoo.com.hk> writes:

> 
> Hi Marcel!
> I've set the SDP service profile and the
> attributes for headset and set the class of my
> computer to headset. Then my T610 can search my Linux
> PC as headset. However, when I pressed "connect" item,
> the phone tried to connect to the PC, but then the
> phone showed "Bluetooth connection failed". Is there
> any thing that I need to set in my PC, or how to
> modify my sdp program so that the phone can connect to
> PC?
> My steps are as follows:
> 1.run my sdp program to add service and set the
> attributes.
> 2.change the class of my PC to be the one of headset.
> 3.let T610 to search my PC and then connect to PC.
> Is there anything wrong here?
> Thank you very much.
> Michael
> 
Hi,
After initialising the rfcomm connection (phone to PC; phone gets the setup 
data via sdp from pc) the phone tries to initialize the "HS/HF-connection" via 
AT-commands - as I know.

You should have a look to the following pages regarding HF and HS 
support over BT too:

http://bluetooth-alsa.sourceforge.net/
http://www.crazygreek.co.uk/content/chan_bluetooth
http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree

Regards
Andreas





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-209686432-1111585346=:2667
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>Hi Andreas!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Thank you very much for your email. Actually, I can connect the phone to PC now. But the new problem arises. Last time I did the things i.e. adding sdp headset profile, setting the class of my PC to be headset and then setting the channel in SDP and hciconfig, separately. Now, I wish to integrate these three separate jobs into my project's main program. The procedure is as that stated above. Then I put the part of socket programming in my main program, and this part can be said to&nbsp;come from rfcomm/main.c's cmd_listen function. But when my phone can connect to PC, the terminal shows "dev/rfcomm0: no such device". Then, I don't preset the address of my phone, but then when the phone can connect to PC, the following ios shown: "Can't create rfcomm TTY socket: too many open files in the system" or "dev/rfcomm0: connection refused". There is a note that in order to continue my program, the modem should be opened successfully, and the menu should be sen
 t to my
 phine successfully. So, I wish to know what's wrong about my program, and how&nbsp;I can fix it. I attach the programs here for you, and hope that other users, can find it out. Thank you very much&nbsp;for your kindness.</DIV>
<DIV>P.S. bic_michael.c and bic_rfcomm.c are main programs without and with the part from rfcomm/main.c respectively, and bic_sdp.c and bic_sdp.h are files to be included in /usr/include</DIV>
<DIV>Michael&nbsp;<BR><BR><B><I>Andreas &lt;andreas.knuth@daimlerchrysler.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Ka Kin Cheung <MICHAELHKU2002 <at>yahoo.com.hk&gt; writes:<BR><BR>&gt; <BR>&gt; Hi Marcel!<BR>&gt; I've set the SDP service profile and the<BR>&gt; attributes for headset and set the class of my<BR>&gt; computer to headset. Then my T610 can search my Linux<BR>&gt; PC as headset. However, when I pressed "connect" item,<BR>&gt; the phone tried to connect to the PC, but then the<BR>&gt; phone showed "Bluetooth connection failed". Is there<BR>&gt; any thing that I need to set in my PC, or how to<BR>&gt; modify my sdp program so that the phone can connect to<BR>&gt; PC?<BR>&gt; My steps are as follows:<BR>&gt; 1.run my sdp program to add service and set the<BR>&gt; attributes.<BR>&gt; 2.change the class of my PC to be the one of headset.<BR>&gt; 3.let T610 to search my PC and then connect to PC.<BR>&gt; Is there anything wrong here?<BR>&gt; Thank you very much.<BR>&gt; Michael<BR>&
 gt;
 <BR>Hi,<BR>After initialising the rfcomm connection (phone to PC; phone gets the setup <BR>data via sdp from pc) the phone tries to initialize the "HS/HF-connection" via <BR>AT-commands - as I know.<BR><BR>You should have a look to the following pages regarding HF and HS <BR>support over BT too:<BR><BR>http://bluetooth-alsa.sourceforge.net/<BR>http://www.crazygreek.co.uk/content/chan_bluetooth<BR>http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree<BR><BR>Regards<BR>Andreas<BR><BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE></DIV><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-209686432-1111585346=:2667--

--0-1102683115-1111585346=:2667
Content-Type: text/plain; name="bic_michael.c"
Content-Description: bic_michael.c
Content-Disposition: inline; filename="bic_michael.c"

/*****************************************************************************/

/*** (Final Year Project Bluetooth-Infrared Converter) bic_michael.c  	   ***/

/***                                                  Michael Cheung Ka Kin***/

/*****************************************************************************/

  

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


void devicecontrol(MYSQL *mysql, char type[], char remote[])
{
	char query_buffer[1000];
	char buffer[1024];
	char command_buffer[1024];
	char device[100][20];
	char model[100][20];
	int item_brand;
	int item_model;
	int brand_selected=0;
    int model_selected=0;
	int db_success;
	int ans_selected[100];
	int a,b,c,i,j,k,l;
	int count1;
	int count2;
    repeat1:
    item_brand=0;
    item_model=0;
    sprintf(query_buffer, "SELECT distinct(Brand) from %s ORDER by Brand", type);
	if (mysql_query(mysql, query_buffer)==0)
	{
		db_success=1;
		result=mysql_use_result(mysql);
		while (row = mysql_fetch_row(result))
		{
			item_brand++;
            strcpy(device[item_brand-1], row[0]);
			}
      	mysql_free_result(result); 
		}
	else
	{
		printf("There is an error when showing result! \n");
		db_success=0;
		}
	if (db_success==1)
	{
	    for (i=0; i<item_brand; i++)
			printf("%d. %s \n", i+1, device[i]);
		sprintf(command_buffer, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_brand+1);
		strcpy(command, command_buffer);
		for (j=0; j<item_brand; j++)
		{
			sprintf(command_buffer, ",\"%s\"", device[j]);
			strcat(command, command_buffer);
			}
		sprintf(command_buffer, ",\"quit\",\r");
		strcat(command, command_buffer);
		ret_code=put_command (command, answer, sizeof (answer), 5, 0);
		for (k=0; k<item_brand+1; k++)
			ans_selected[k]=0;
		count1=1;
		while (count1)
		{
			ret_code = put_command ("", answer, sizeof (answer), 5, 0);
			for (l=0; l<item_brand+1; l++)
			{
				sprintf (buffer, "*EAMI: %d", l+1);
				ans_selected[l] = (NULL != strstr (answer, buffer));
				if (ans_selected[l]==1)
				{
					count1=0;
					brand_selected=l;
					break;
					}
				}
			}
	    if (ans_selected[item_brand])
			return;
		else 
        {
			printf("You have chosen %s %s \n", device[brand_selected], type);
			sprintf(query_buffer, "SELECT Model from %s WHERE Brand='%s' ORDER by Model", type, device[brand_selected]);
			if (mysql_query(mysql, query_buffer)==0)
			{
				db_success=1;
				result=mysql_use_result(mysql);
				while (row = mysql_fetch_row(result))
				{
					item_model++;
					strcpy(model[item_model-1], row[0]);
					}
      				mysql_free_result(result); 
				}
			else 
			{
				printf("There is an error when showing result! \n");
				db_success=0;
				}
			if (db_success==1)
			{
				for (i=0; i<item_model; i++)
					printf("%d. %s \n", i+1, model[i]);
				sprintf(command_buffer, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_model+1);
				strcpy(command, command_buffer);
				for (a=0; a<item_model; a++)
				{
					sprintf(command_buffer, ",\"%s\"", model[a]);
					strcat(command, command_buffer);
					}
				sprintf(command_buffer, ",\"quit\",\r");
				strcat(command, command_buffer);
				ret_code=put_command (command, answer, sizeof (answer), 5, 0);
				for (b=0; b<item_model+1; b++)
					ans_selected[b]=0;
				count2=1;
				while (count2)
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					for (c=0; c<item_model+1; c++)
					{
						sprintf (buffer, "*EAMI: %d", c+1);
						ans_selected[c] = (NULL != strstr (answer, buffer));
						if (ans_selected[c]==1)
						{
							count2=0;
							model_selected=c;
							break;
							}
						}
					}
				if (ans_selected[item_model])
					goto repeat1;
				else
				{
					strcpy(remote, model[model_selected]);
					printf("You have chosen %s %s %s \n", device[brand_selected],  remote, type);
					if (!strcmp(type,"TV"))
						TVcontrol(remote);
					else if (!strcmp(type,"CD"))
						CDcontrol(remote);
					else if (!strcmp(type,"VCD"))
						VCDcontrol(remote);
					else if (!strcmp(type,"DVD"))
						DVDcontrol(remote);
					else if (!strcmp(type,"VCR"))
						VCRcontrol(remote);
					else if (!strcmp(type,"Projector"))
						projectorcontrol(remote);
					}
				}
			}
		}
	}

void TVcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	int channel_count=0;
	int win;
	printf("The user has entered TV mode \n");
	TV:
	sprintf (command, "AT*EASM=\"TV\",1,1,7,\"Power\",\"Channel\",\"Volume\",\"Menu\",\"Language\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<7; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<7; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[6])
	{
		printf("The user has quitted TV mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the TV \n");
				else
					printf("Error on turning on/off TV! Please check if the TV's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user wishes to change channel\n");
				sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
			    ret_code = put_command (command, answer, sizeof (answer), 7, 0);
			    win=0;
			    char *location=NULL;
			    while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("\nThe user has chosen channel %s \n", outputint);
					channel_count++;
					if (channel_count==2)
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
						//system(instruct);
						channel_count=0;
						}
					goto TV;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("\nThe user has chosen channel %s \n", outputint);
					goto TV;
					}
				break;
			case 3:
				printf("The user has entered volume mode\n");
				vol:				
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<3; c++)
					ans_select[c]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto TV;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 4:
				menu_count=0;
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"Menu\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					break;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has chosen an item in the menu \n");
						menu_count++;
						if (menu_count==1)
							goto menu;
						else 
							goto TV;
						}
				    }
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s lang", remote);
				//system(instruct);
				printf("The user has changed language \n");
				break;
			case 6:
				printf("The user has entered others mode \n");
				Other:
				sprintf (command, "AT*EASM=\"Others\",1,1,4,\"Mode\",\"Silent\",\"Call\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (f=0; f<4; f++)
					ans_select[f]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					break;
	      		else if (ans_select[0])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s mode", remote);
					//system(instruct);
					printf("The user has changed mode \n");
					goto Other;
					}
				else if (ans_select[1])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
					//system(instruct);
					printf("The user has chosen to let TV be silent \n");
					goto Other;
					}
				else if (ans_select[2])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s call", remote);
					//system(instruct);
					printf("The user has done call function \n");
					goto Other;
					}
				break;
			default:
				break;
			}
		goto TV;
		}
	}

void CDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered CD mode \n");
	CD:
	sprintf (command, "AT*EASM=\"CD\",1,1,6,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<6; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<6; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[5])
	{
		printf("The user has quitted CD mode\n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the CD player \n");
				else
					printf("Error on turning on/off CD player! Please check if the CD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
			    ret_code = put_command (command, answer, sizeof (answer), 7, 0);
			    win=0;
			    char *location=NULL;
			    while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto CD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto CD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto CD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The CD is playing \n");
							goto play_key;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The CD is stopped \n");
							goto play_key;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The CD is paused \n");
							goto play_key;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The CD is fast-backwarding \n");
							goto play_key;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The CD is fast-forwarding \n");
							goto play_key;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The CD is playing the previous chapter \n");
							goto play_key;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The CD is playing next chapter \n");
							goto play_key;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play_key;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The CD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The CD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The CD is ejected out \n");
							goto play_key;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto CD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto CD;
						}
					}
				break;
			default:
				break;
			}
		goto CD;
		}
	}

void VCDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int chapter1;
	int chapter2;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered VCD mode\n");
	VCD:
	sprintf (command, "AT*EASM=\"VCD\",1,1,8,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"Display\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<8; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<8; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[7])
	{
		printf("The user has quitted from VCD mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the VCD player \n");
				else
					printf("Error on turning on/off VCD player! Please check if the VCD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
				ret_code = put_command (command, answer, sizeof (answer), 7, 0);
				win=0;
				char *location=NULL;
				while (!win)
				{	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
				outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto VCD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto VCD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The VCD is playing \n");
							goto play;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The VCD is stopped \n");
							goto play;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The VCD is paused \n");
							goto play;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The VCD is fast-backwarding \n");
							goto play;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The VCD is fast-forwarding \n");
							goto play;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The VCD is playing the previous chapter \n");
							goto play;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The VCD is playing next chapter \n");
							goto play;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The VCD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The VCD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The VCD is ejected out \n");
							goto play;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto VCD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto VCD;
						}
				}
				break;
			case 6:
				printf("The user has entered display setting mode \n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,9,\"Display?\",\"Zoom?\",\"Browse?\",\"Signal mode?\",\"Caption?\",\"Angle?\",\"Channel?\",\"Title?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<9; a++)
					ans_select[a]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (b=0; b<9; b++)
					{
						sprintf (buffer, "*EAMI: %d", b+1);
						ans_select[b] = (NULL != strstr (answer, buffer));
						if (ans_select[b]==1)
						{
							choice1=0;
							con=b+1;
							break;
							}
						}
					}
				if (ans_select[8])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s display", remote);
						//system(instruct);
						printf("The user has chosen a display format \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s zoom", remote);
						//system(instruct);
						printf("The user has chosen a zooming aspects \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s browse", remote);
						//system(instruct);
						printf("The user has chosen to browse \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s signal_mode", remote);
						//system(instruct);
						printf("The user has searched a signal mode\n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s caption", remote);
						//system(instruct);
						printf("The user has chosen (not) to show caption\n");
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s angle", remote);
						//system(instruct);
						printf("The user has chosen a display angle \n");
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s channel", remote);
						//system(instruct);
						printf("The user has chosen a display channel \n");
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s title", remote);
						//system(instruct);
						printf("The user has chosen to show a title \n");
						}
                    goto display;
					}
				break;
			case 7:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Setup\",\"Silent\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s setup", remote);
						//system(instruct);
						printf("The user has entered setup menu \n");
						setup:
						sprintf(command, "AT*EASM=\"Setup\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has chosen an item\n");
								goto others;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
						//system(instruct);
						printf("The user has made the VCD player silently \n");
						}
                    goto others;
					}
				break;
			default:
				break;
			}
		goto VCD;
		}
	}

void DVDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int chapter1;
	int chapter2;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered DVD mode \n");
	DVD:
	sprintf (command, "AT*EASM=\"DVD\",1,1,8,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"Display\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<8; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<8; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[7])
	{
		printf("The user has quitted from DVD mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the DVD player \n");
				else
					printf("Error on turning on/off DVD player! Please check if the DVD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
				ret_code = put_command (command, answer, sizeof (answer), 7, 0);
				win=0;
			    char *location=NULL;
				while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
				outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto DVD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto DVD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The DVD is playing \n");
							goto play;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The DVD is stopped \n");
							goto play;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The DVD is paused \n");
							goto play;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The DVD is fast-backwarding \n");
							goto play;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The DVD is fast-forwarding \n");
							goto play;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The DVD is playing the previous chapter \n");
							goto play;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The DVD is playing next chapter \n");
							goto play;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The DVD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The DVD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The DVD is ejected out \n");
							goto play;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto DVD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto DVD;
						}
				}
				break;
			case 6:
				printf("The user has entered display setting mode \n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,9,\"Display?\",\"Zoom?\",\"Browse?\",\"Signal mode?\",\"Caption?\",\"Angle?\",\"Channel?\",\"Title?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<9; a++)
					ans_select[a]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (b=0; b<9; b++)
					{
						sprintf (buffer, "*EAMI: %d", b+1);
						ans_select[b] = (NULL != strstr (answer, buffer));
						if (ans_select[b]==1)
						{
							choice1=0;
							con=b+1;
							break;
							}
						}
					}
				if (ans_select[8])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s display", remote);
						//system(instruct);
						printf("The user has chosen a display format \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s zoom", remote);
						//system(instruct);
						printf("The user has chosen a zooming aspects \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s browse", remote);
						//system(instruct);
						printf("The user has chosen to browse \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s signal_mode", remote);
						//system(instruct);
						printf("The user has searched a signal mode\n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s caption", remote);
						//system(instruct);
						printf("The user has chosen (not) to show caption\n");
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s angle", remote);
						//system(instruct);
						printf("The user has chosen a display angle \n");
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s channel", remote);
						//system(instruct);
						printf("The user has chosen a display channel \n");
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s title", remote);
						//system(instruct);
						printf("The user has chosen to show a title \n");
						}
                    goto display;
					}
				break;
			case 7:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Setup\",\"Silent\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s setup", remote);
						//system(instruct);
						printf("The user has entered setup menu \n");
						setup:
						sprintf(command, "AT*EASM=\"Setup\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has chosen an item\n");
								goto others;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
						//system(instruct);
						printf("The user has made the DVD player silently \n");
						}
                    goto others;
					}
				break;
			default:
				break;
			}
		goto DVD;
		}
	}

void VCRcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered VCR mode \n");
	VCR:
	sprintf (command, "AT*EASM=\"VCR\",1,1,6,\"Power\",\"Channel\",\"Play\",\"Recording\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<6; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<6; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[5])
	{
		printf("The user has quitted from VCR mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the VCR \n");
				else
					printf("Error on turning on/off VCR! Please check if the VCR's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user wishes to change recording channel\n");
				channel_choice1:
				sprintf (command, "AT*EASM=\"Channel\",1,1,3,\"Change by key?\",\"Change by no.?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCR;
				else if (ans_select[0])
				{
					channel_choice2:
					sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"up channel?\",\"down channel?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (a=0; a<3; a++)
						ans_select[a]=0;
					while (!ans_select[0] && !ans_select[1] && !ans_select[2])
					{
						ret_code = put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
						}
					if (ans_select[2])
						goto channel_choice1;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
							//system(instruct);
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
							//system(instruct);
							}
						goto channel_choice2;
						}
					}
				else if (ans_select[1])
				{
					sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
					ret_code = put_command (command, answer, sizeof (answer), 7, 0);
					win=0;
				    char *location=NULL;
					while (!win)
				    {	
						ret_code = put_command ("", answer, sizeof (answer), 5,0);
						location = strstr(answer, "*EAII: 7,");
						win = (NULL != strstr (answer, "*EAII: 7,"));
						}
					char outputint[3];
					flush (outputint,3);
		  			outputint[0]=answer[location-answer+9];
					outputint[1]=answer[location-answer+10];
					outputint[2]='\0';
					if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
						//system(instruct);
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
						//system(instruct);
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
						//system(instruct);
						printf("The user has chosen channel %s \n", outputint);
						goto VCR;
						}
					else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
						//system(instruct);
						printf("The user has chosen channel %s \n", outputint);
						goto VCR;
						}
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,6,\"Play\",\"Stop/eject?\",\"Pause\",\"Fast backward?\",\"Fast forward?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (b=0; b<6; b++)
					ans_select[b]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (c=0; c<6; c++)
					{
						sprintf (buffer, "*EAMI: %d", c+1);
						ans_select[c]=(NULL != strstr (answer, buffer));
						if (ans_select[c]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto VCR;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
						//system(instruct);
						printf("The user has chosen to play \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
						//system(instruct);
						printf("The user has chosen to stop \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
						//system(instruct);
						printf("The user has chosen to pause/play in step \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
						//system(instruct);
						printf("The user has chosen to fast-backward \n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
						//system(instruct);
						printf("The user has chosen to fast-forward \n");
						}
					goto play;
					}	
				break;
			case 4:
				printf("The user has entered recording mode\n");
				record:
				sprintf (command, "AT*EASM=\"Recording\",1,1,3,\"By key?\",\"By setting time?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s record", remote);
						//system(instruct);
						printf("The VCR is starting recording\n");
						}
					else if (ans_select[1])
					{
						printf("The user is setting the recording information\n");
						record_set:
						sprintf (command, "AT*EASM=\"Record setting\",1,1,3,\"Channel\",\"Time\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (a=0; a<3; a++)
							ans_select[a]=0;
						while (!ans_select[0] && !ans_select[1] && !ans_select[2])
						{
							ret_code = put_command ("", answer, sizeof (answer), 5, 0);
							ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
							ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
							ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
							}
						if (ans_select[2])
							break;
						else if(ans_select[0])
						{
							printf("The user is choosing channel for recording\n");
							sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
							ret_code = put_command (command, answer, sizeof (answer), 7, 0);
							win=0;
							char *location=NULL;
							while (!win)
							{	
								ret_code = put_command ("", answer, sizeof (answer), 5,0);
								location = strstr(answer, "*EAII: 7,");
								win = (NULL != strstr (answer, "*EAII: 7,"));
								}
							char outputint[3];
							flush (outputint,3);
					  		outputint[0]=answer[location-answer+9];
	  						outputint[1]=answer[location-answer+10];
							outputint[2]='\0';
							if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
								//system(instruct);
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
								//system(instruct);
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
								//system(instruct);
								printf("The user has chosen channel %s \n", outputint);
								goto record_set;
								}
							else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
								//system(instruct);
								printf("The user has chosen channel %s \n", outputint);
								goto record_set;
								}
							}
						else if(ans_select[1])
						{
							printf("The user is setting record time\n");
							rec_time:
							while (1)
					  		{
								sprintf (command, "AT*EAID=9,1,\"Start Date\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	  							win=0;
								char *location=NULL;
	  							while (!win)
								{	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 9,");
									win = (NULL != strstr (answer, "*EAII: 9,"));
									}
								char year[3];
								flush (year,3);
					  			year[0]=answer[location-answer+10];
	  							year[1]=answer[location-answer+11];
					  			year[2]='\0';
	  							char month[3];
								flush (month,3);
	  							month[0]=answer[location-answer+13];
					  			month[1]=answer[location-answer+14];
	  							month[2]='\0';
	  							char day[3];
								flush (day,3);
	  							day[0]=answer[location-answer+16];
					  			day[1]=answer[location-answer+17];
	  							day[2]='\0';
	  							printf ("%s\n",year);
	  							printf ("%s\n",month);
					  			printf ("%s\n",day);	
								printf ("Start Date (yy/mm/dd): %s/%s/%s\n", year, month, day);
								win=0;
								location=NULL;
                                sprintf (command, "AT*EAID=10,1,\"Start Time\"\r");
                                ret_code = put_command (command, answer, sizeof (answer), 5, 0);
                                while (!win)
                                {
                                    ret_code = put_command ("", answer, sizeof (answer), 20, 0);
                                    location = strstr(answer, "*EAII: 10,");
                                    win = (NULL != strstr (answer, "*EAII: 10,"));
									}
                                printf("%s\n", answer);
                                char hour[3];
                                flush (hour,3);
                                //hour[0]=answer[location-answer+11];
                                //hour[1]=answer[location-answer+12];
								hour[0]='1';
								hour[1]=answer[location-answer+11];
                                hour[2]='\0';
                                char min[3];
                                flush (min,3);
                                min[0]=answer[location-answer+13];
                                min[1]=answer[location-answer+14];
                                min[2]='\0';
                                printf ("%s\n", hour);
                                printf ("%s\n", min);
                                printf ("Start Time (hh:mm): %s:%s\n", hour, min);
                                win=0;
                                location=NULL;
					  			sprintf (command, "AT*EAID=9,1,\"End Date\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					  			while (!win)
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									location = strstr(answer, "*EAII: 9,");
									win = (NULL != strstr (answer, "*EAII: 9,"));
									}
					  			char end_year[3];
								flush (end_year,3);
	  							end_year[0]=answer[location-answer+10];
	  							end_year[1]=answer[location-answer+11];
	  							end_year[2]='\0';
					  			char end_month[3];
								flush (end_month,3);
					  			end_month[0]=answer[location-answer+13];
					  			end_month[1]=answer[location-answer+14];
	  							end_month[2]='\0';
	  							char end_day[3];
								flush (end_day,3);
	  							end_day[0]=answer[location-answer+16];
					  			end_day[1]=answer[location-answer+17];
	  							end_day[2]='\0';
					  			printf("%s\n",end_year);
	  							printf("%s\n",end_month);
					  			printf("%s\n",end_day);
								printf("End Date (yy/mm/dd): %s/%s/%s\n", end_year, end_month, end_day);
								win=0;
								location=NULL;
								sprintf (command, "AT*EAID=10,1,\"End Time\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	  							while (!win)
								{
									ret_code = put_command ("", answer, sizeof (answer), 20, 0);
									location = strstr(answer, "*EAII: 10,");
									win = (NULL != strstr (answer, "*EAII: 10,"));
									}
								printf("%s",answer);
								char end_hour[3];
								flush (end_hour,3);
								end_hour[0]='1';
	  							//end_hour[0]=answer[location-answer+11];
					  			end_hour[1]=answer[location-answer+11];
	  							end_hour[2]='\0';
	  							char end_min[3];
								flush (end_min,3);
	  							end_min[0]=answer[location-answer+13];
	  							end_min[1]=answer[location-answer+14];
	  							end_min[2]='\0';
	  							printf("%s\n",end_hour);
	  							printf("%s\n",end_min);
								printf("End Time (hh:mm): %s:%s\n", end_hour, end_min);							
								goto record_set;
								}
							}
						}
					}
				break;
			case 5:
				printf("The user enters other mode\n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Menu\",\"Guide\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has entered menu setting mode\n");
						vcr_menu:
						sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"select\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s select", remote);
								//system(instruct);
								printf("The user has selected an item in menu\n");
								goto VCR;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s guide", remote);
						//system(instruct);
						printf("The user has entered guide mode\n");
						vcr_guide:
						sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"select\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s guide", remote);
								//system(instruct);
								goto VCR;
								}
							}
						}
					}
				break;
			default:
				break;
			}
		goto VCR;
		}
	}

void projectorcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered projector mode \n");
	projector:
	sprintf (command, "AT*EASM=\"Projector\",1,1,7,\"Power\",\"menu\",\"input\",\"Display\",\"volume\",\"others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<7; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<7; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[6])
	{
		printf("The user has quitted from projector mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				printf("The user has entered the power mode\n");
				power:
				sprintf (command, "AT*EASM=\"Power\",1,1,3,\"Power\",\"Standby\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<3; c++)
					ans_select[c]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
						//system(instruct);
						if (!system(instruct))
							printf("The user has turned on/off the projector \n");
						else
							printf("Error on turning on/off projector!\n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s standby", remote);
						//system(instruct);
						if (!system(instruct))
							printf("The user has turned the projector to standby mode\n");
						else
							printf("Error on turning the projector to standby mode!\n");
						}
					goto power;
					}
				break;
			case 2:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered the power mode\n");
				projector_menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,9,\"up\",\"down\",\"left\",\"right\",\"enter\",\"reset\",\"menu\",\"undo\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<9; c++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<9; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[8])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has selected an item in menu\n");
						goto projector_menu;
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s reset", remote);
						//system(instruct);
						printf("The user has reset all settings to default one\n");
						goto projector_menu;
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has quitted from menu\n");
						goto projector;
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s undo", remote);
						//system(instruct);
						printf("The user has cancelled the setting\n");
						goto projector;
						}
					}
				break;
			case 3:
				printf("The user has entered input mode\n");
				input:
				sprintf (command, "AT*EASM=\"Input\",1,1,8,\"mode 1\",\"mode 2\",\"mode 3\",\"mode 4\",\"mode 5\",\"Computer\",\"Video\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<7; c++)
					ans_select[c]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<7; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[7])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input1", remote);
						//system(instruct);
						printf("The user has chosen input mode 1\n");
						goto input;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input2", remote);
						//system(instruct);
						printf("The user has chosen input mode 2\n");
						goto input;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input3", remote);
						//system(instruct);
						printf("The user has chosen input mode 3\n");
						goto input;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input4", remote);
						//system(instruct);
						printf("The user has chosen input mode 4\n");
						goto input;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input5", remote);
						//system(instruct);
						printf("The user has chosen input mode 5\n");
						goto input;
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s computer", remote);
						//system(instruct);
						printf("The user has chosen input from computer \n");
						goto input;
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s video", remote);
						//system(instruct);
						printf("The user has chosen input from video\n");
						goto input;
						}
					}
				break;
			case 4:
				printf("The user has entered the display mode\n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,7,\"Image\",\"Keystone\",\"Auto\",\"PinP\",\"Freeze\",\"Aspect\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<7; c++)
					ans_select[c]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<7; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[6])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						printf("The user has entered image mode\n");
						image:
						sprintf (command, "AT*EASM=\"Image\",1,1,7,\"Focus\",\"Zoom\",\"Magnify\",\"Position\",\"RGB\",\"Blank\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto display;			
						else
						{
							if (ans_select[0])
							{
								printf("The user is changing focus\n");
								focus:
								sprintf (command, "AT*EASM=\"Focus\",1,1,3,\"increase?\",\"decrease?\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								while (!ans_select[0] && !ans_select[1] && !ans_select[2])
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
									ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
									ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upfocus", remote);
										//system(instruct);
										printf("The user has increased the focus\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downfocus", remote);
										//system(instruct);
										printf("The user has decreased the focus\n");
										}
									goto focus;
									}
								}
							else if (ans_select[1])
							{
								printf("The user is changing the zooming level\n");
								zoom:
								sprintf (command, "AT*EASM=\"zoom\",1,1,3,\"increase?\",\"decrease?\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								while (!ans_select[0] && !ans_select[1] && !ans_select[2])
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
									ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
									ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upfocus", remote);
										//system(instruct);
										printf("The user has zoomed in\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downfocus", remote);
										//system(instruct);
										printf("The user has zoomed out\n");
										}
									goto zoom;
									}
								}
							else if (ans_select[2])
							{
								printf("The user is changing the magnification\n");
								magnify:
								sprintf (command, "AT*EASM=\"magnify\",1,1,3,\"up\",\"down\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								choice1=1;
								while (choice1)
								{
									ret_code=put_command ("", answer, sizeof (answer), 5, 0);
									for (h=0; h<3; h++)
									{
										sprintf (buffer, "*EAMI: %d", h+1);
										ans_select[h]=(NULL != strstr (answer, buffer));
										if (ans_select[h]==1)
										{
											choice1=0;
											break;
											}
										}
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
										//system(instruct);
										printf("The user has magnified the display\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
										//system(instruct);
										printf("The user has made the display smaller\n");
										}
									goto magnify;
									}
								}
							else if (ans_select[3])
							{
								printf("The user is changing the display's position\n");
								position:
								sprintf (command, "AT*EASM=\"position\",1,1,5,\"up\",\"down\",\"left\",\"right\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<5; g++)
									ans_select[g]=0;
								choice1=1;
								while (choice1)
								{
									ret_code=put_command ("", answer, sizeof (answer), 5, 0);
									for (h=0; h<5; h++)
									{
										sprintf (buffer, "*EAMI: %d", h+1);
										ans_select[h]=(NULL != strstr (answer, buffer));
										if (ans_select[h]==1)
										{
											choice1=0;
											break;
											}
										}
									}
								if (ans_select[4])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
										//system(instruct);
										printf("The display has been shifted up\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
										//system(instruct);
										printf("The display has been shifted down\n");
										}
									else if (ans_select[2])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
										//system(instruct);
										printf("The display has been shifted left\n");
										}
									else if (ans_select[3])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
										//system(instruct);
										printf("The display has been shifted right\n");
										}
									goto position;
									}
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s rgb", remote);
								//system(instruct);
								printf("The user has changed the display in rgb mode\n");
								goto image;
								}
							else if (ans_select[5])
							{	
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s blank", remote);
								//system(instruct);
								printf("The display has been blanked\n");
								goto image;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s keystone", remote);
						//system(instruct);
						printf("The user has entered keystone mode\n");
						keystone:
						sprintf (command, "AT*EASM=\"Keystone\",1,1,7,\"up\",\"down\",\"left\",\"right\",\"keystone\",\"undo\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto display;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The user has increased the level of the keystone\n");
								goto keystone;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The user has decreased the level of the keystone\n");
								goto keystone;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The user has changed the direction of keystone\n");
								goto keystone;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The user has changed the direction of keystone\n");
								goto keystone;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s keystone", remote);
								//system(instruct);
								printf("The user has closed the keystone dialog\n");
								goto display;
								}
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s undo", remote);
								//system(instruct);
								printf("The user has cleared the keystone change\n");
								goto display;
								}
							}
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s auto", remote);
						//system(instruct);
						printf("The user has chosen auto position mode\n");
						goto display;	
						}
					else if (ans_select[3])
					{
						printf("The user has chosen Picture-in-picture mode\n");
						pinp:
						sprintf (command, "AT*EASM=\"PinP\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"PinP\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<6; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<6; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto image;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The user has switching the images\n");
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The user has switching the images\n");
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The user has changed image position\n");
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The user has changed image position\n");
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pinp", remote);
								//system(instruct);
								printf("The sub image disappeared\n");
								}
							goto pinp;
							}
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s freeze", remote);
						//system(instruct);
						printf("The display is freezed\n");
						goto display;	
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s aspect", remote);
						//system(instruct);
						printf("The user has changed the aspect\n");
						goto display;	
						}
					}
				break;
			case 5:
				printf("The user has entered volume mode \n");
				volume:
				sprintf (command, "AT*EASM=\"Volume\",1,1,4,\"increase vol?\",\"decrease vol?\",\"mute?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<4; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					goto projector;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume\n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s mute", remote);
						//system(instruct);
						printf("The projector was set to be silent \n");
						}
                    goto volume;
					}
				break;
			case 6:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,4,\"search\",\"laser\",\"mouse control\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<4; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					goto projector;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s search", remote);
						//system(instruct);
						printf("The projector is searching..... \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s laser", remote);
						//system(instruct);
						printf("The projector is changed into laser mode \n");
						}				
					else if (ans_select[2])
					{
						printf("The user has entered mouse mode \n");
						mouse:
						sprintf (command, "AT*EASM=\"Mouse control\",1,1,7,\"up\",\"down\",\"left\",\"right\",\"enter\",\"reset\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The cursor is moving upward \n");
								goto mouse;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The cursor is moving downward \n");
								goto mouse;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The cursor is moving left \n");
								goto mouse;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The cursor is moving right \n");
								goto mouse;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The cursor has chosen a point \n");
								goto mouse;
								}
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s reset", remote);
								//system(instruct);
								printf("The user has right-clicked the mouse \n");
								goto mouse;
								}
							}
						}
					}
				break;
			default:
				break;
			}
		goto projector;
		}
	}


--0-1102683115-1111585346=:2667
Content-Type: text/plain; name="bic_rfcomm.c"
Content-Description: bic_rfcomm.c
Content-Disposition: inline; filename="bic_rfcomm.c"

/*****************************************************************************/

/*** (Final Year Project Bluetooth-Infrared Converter) bic_michael.c  	   ***/

/***                                                  Michael Cheung Ka Kin***/

/*****************************************************************************/


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


void devicecontrol(MYSQL *mysql, char type[], char remote[])
{
	char query_buffer[1000];
	char buffer[1024];
	char command_buffer[1024];
	char device[100][20];
	char model[100][20];
	int item_brand;
	int item_model;
	int brand_selected=0;
    int model_selected=0;
	int db_success;
	int ans_selected[100];
	int a,b,c,i,j,k,l;
	int count1;
	int count2;
    repeat1:
    item_brand=0;
    item_model=0;
    sprintf(query_buffer, "SELECT distinct(Brand) from %s ORDER by Brand", type);
	if (mysql_query(mysql, query_buffer)==0)
	{
		db_success=1;
		result=mysql_use_result(mysql);
		while (row = mysql_fetch_row(result))
		{
			item_brand++;
            strcpy(device[item_brand-1], row[0]);
			}
      	mysql_free_result(result); 
		}
	else
	{
		printf("There is an error when showing result! \n");
		db_success=0;
		}
	if (db_success==1)
	{
	    for (i=0; i<item_brand; i++)
			printf("%d. %s \n", i+1, device[i]);
		sprintf(command_buffer, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_brand+1);
		strcpy(command, command_buffer);
		for (j=0; j<item_brand; j++)
		{
			sprintf(command_buffer, ",\"%s\"", device[j]);
			strcat(command, command_buffer);
			}
		sprintf(command_buffer, ",\"quit\",\r");
		strcat(command, command_buffer);
		ret_code=put_command (command, answer, sizeof (answer), 5, 0);
		for (k=0; k<item_brand+1; k++)
			ans_selected[k]=0;
		count1=1;
		while (count1)
		{
			ret_code = put_command ("", answer, sizeof (answer), 5, 0);
			for (l=0; l<item_brand+1; l++)
			{
				sprintf (buffer, "*EAMI: %d", l+1);
				ans_selected[l] = (NULL != strstr (answer, buffer));
				if (ans_selected[l]==1)
				{
					count1=0;
					brand_selected=l;
					break;
					}
				}
			}
	    if (ans_selected[item_brand])
			return;
		else 
        {
			printf("You have chosen %s %s \n", device[brand_selected], type);
			sprintf(query_buffer, "SELECT Model from %s WHERE Brand='%s' ORDER by Model", type, device[brand_selected]);
			if (mysql_query(mysql, query_buffer)==0)
			{
				db_success=1;
				result=mysql_use_result(mysql);
				while (row = mysql_fetch_row(result))
				{
					item_model++;
					strcpy(model[item_model-1], row[0]);
					}
      				mysql_free_result(result); 
				}
			else 
			{
				printf("There is an error when showing result! \n");
				db_success=0;
				}
			if (db_success==1)
			{
				for (i=0; i<item_model; i++)
					printf("%d. %s \n", i+1, model[i]);
				sprintf(command_buffer, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_model+1);
				strcpy(command, command_buffer);
				for (a=0; a<item_model; a++)
				{
					sprintf(command_buffer, ",\"%s\"", model[a]);
					strcat(command, command_buffer);
					}
				sprintf(command_buffer, ",\"quit\",\r");
				strcat(command, command_buffer);
				ret_code=put_command (command, answer, sizeof (answer), 5, 0);
				for (b=0; b<item_model+1; b++)
					ans_selected[b]=0;
				count2=1;
				while (count2)
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					for (c=0; c<item_model+1; c++)
					{
						sprintf (buffer, "*EAMI: %d", c+1);
						ans_selected[c] = (NULL != strstr (answer, buffer));
						if (ans_selected[c]==1)
						{
							count2=0;
							model_selected=c;
							break;
							}
						}
					}
				if (ans_selected[item_model])
					goto repeat1;
				else
				{
					strcpy(remote, model[model_selected]);
					printf("You have chosen %s %s %s \n", device[brand_selected],  remote, type);
					if (!strcmp(type,"TV"))
						TVcontrol(remote);
					else if (!strcmp(type,"CD"))
						CDcontrol(remote);
					else if (!strcmp(type,"VCD"))
						VCDcontrol(remote);
					else if (!strcmp(type,"DVD"))
						DVDcontrol(remote);
					else if (!strcmp(type,"VCR"))
						VCRcontrol(remote);
					else if (!strcmp(type,"Projector"))
						projectorcontrol(remote);
					}
				}
			}
		}
	}

void TVcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	int channel_count=0;
	int win;
	printf("The user has entered TV mode \n");
	TV:
	sprintf (command, "AT*EASM=\"TV\",1,1,7,\"Power\",\"Channel\",\"Volume\",\"Menu\",\"Language\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<7; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<7; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[6])
	{
		printf("The user has quitted TV mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the TV \n");
				else
					printf("Error on turning on/off TV! Please check if the TV's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user wishes to change channel\n");
				sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
			    ret_code = put_command (command, answer, sizeof (answer), 7, 0);
			    win=0;
			    char *location=NULL;
			    while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("\nThe user has chosen channel %s \n", outputint);
					channel_count++;
					if (channel_count==2)
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
						//system(instruct);
						channel_count=0;
						}
					goto TV;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("\nThe user has chosen channel %s \n", outputint);
					goto TV;
					}
				break;
			case 3:
				printf("The user has entered volume mode\n");
				vol:				
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<3; c++)
					ans_select[c]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto TV;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 4:
				menu_count=0;
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"Menu\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					break;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has chosen an item in the menu \n");
						menu_count++;
						if (menu_count==1)
							goto menu;
						else 
							goto TV;
						}
				    }
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s lang", remote);
				//system(instruct);
				printf("The user has changed language \n");
				break;
			case 6:
				printf("The user has entered others mode \n");
				Other:
				sprintf (command, "AT*EASM=\"Others\",1,1,4,\"Mode\",\"Silent\",\"Call\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (f=0; f<4; f++)
					ans_select[f]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					break;
	      		else if (ans_select[0])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s mode", remote);
					//system(instruct);
					printf("The user has changed mode \n");
					goto Other;
					}
				else if (ans_select[1])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
					//system(instruct);
					printf("The user has chosen to let TV be silent \n");
					goto Other;
					}
				else if (ans_select[2])
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s call", remote);
					//system(instruct);
					printf("The user has done call function \n");
					goto Other;
					}
				break;
			default:
				break;
			}
		goto TV;
		}
	}

void CDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered CD mode \n");
	CD:
	sprintf (command, "AT*EASM=\"CD\",1,1,6,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<6; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<6; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[5])
	{
		printf("The user has quitted CD mode\n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the CD player \n");
				else
					printf("Error on turning on/off CD player! Please check if the CD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
			    ret_code = put_command (command, answer, sizeof (answer), 7, 0);
			    win=0;
			    char *location=NULL;
			    while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto CD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto CD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto CD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The CD is playing \n");
							goto play_key;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The CD is stopped \n");
							goto play_key;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The CD is paused \n");
							goto play_key;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The CD is fast-backwarding \n");
							goto play_key;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The CD is fast-forwarding \n");
							goto play_key;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The CD is playing the previous chapter \n");
							goto play_key;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The CD is playing next chapter \n");
							goto play_key;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play_key;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The CD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The CD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The CD is ejected out \n");
							goto play_key;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto CD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto CD;
						}
					}
				break;
			default:
				break;
			}
		goto CD;
		}
	}

void VCDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int chapter1;
	int chapter2;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered VCD mode\n");
	VCD:
	sprintf (command, "AT*EASM=\"VCD\",1,1,8,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"Display\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<8; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<8; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[7])
	{
		printf("The user has quitted from VCD mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the VCD player \n");
				else
					printf("Error on turning on/off VCD player! Please check if the VCD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
				ret_code = put_command (command, answer, sizeof (answer), 7, 0);
				win=0;
				char *location=NULL;
				while (!win)
				{	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
				outputint[0]=answer[location-answer+9];
	  			outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto VCD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto VCD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The VCD is playing \n");
							goto play;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The VCD is stopped \n");
							goto play;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The VCD is paused \n");
							goto play;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The VCD is fast-backwarding \n");
							goto play;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The VCD is fast-forwarding \n");
							goto play;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The VCD is playing the previous chapter \n");
							goto play;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The VCD is playing next chapter \n");
							goto play;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The VCD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The VCD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The VCD is ejected out \n");
							goto play;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto VCD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto VCD;
						}
				}
				break;
			case 6:
				printf("The user has entered display setting mode \n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,9,\"Display?\",\"Zoom?\",\"Browse?\",\"Signal mode?\",\"Caption?\",\"Angle?\",\"Channel?\",\"Title?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<9; a++)
					ans_select[a]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (b=0; b<9; b++)
					{
						sprintf (buffer, "*EAMI: %d", b+1);
						ans_select[b] = (NULL != strstr (answer, buffer));
						if (ans_select[b]==1)
						{
							choice1=0;
							con=b+1;
							break;
							}
						}
					}
				if (ans_select[8])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s display", remote);
						//system(instruct);
						printf("The user has chosen a display format \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s zoom", remote);
						//system(instruct);
						printf("The user has chosen a zooming aspects \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s browse", remote);
						//system(instruct);
						printf("The user has chosen to browse \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s signal_mode", remote);
						//system(instruct);
						printf("The user has searched a signal mode\n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s caption", remote);
						//system(instruct);
						printf("The user has chosen (not) to show caption\n");
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s angle", remote);
						//system(instruct);
						printf("The user has chosen a display angle \n");
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s channel", remote);
						//system(instruct);
						printf("The user has chosen a display channel \n");
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s title", remote);
						//system(instruct);
						printf("The user has chosen to show a title \n");
						}
                    goto display;
					}
				break;
			case 7:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Setup\",\"Silent\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s setup", remote);
						//system(instruct);
						printf("The user has entered setup menu \n");
						setup:
						sprintf(command, "AT*EASM=\"Setup\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has chosen an item\n");
								goto others;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
						//system(instruct);
						printf("The user has made the VCD player silently \n");
						}
                    goto others;
					}
				break;
			default:
				break;
			}
		goto VCD;
		}
	}

void DVDcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int chapter1;
	int chapter2;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered DVD mode \n");
	DVD:
	sprintf (command, "AT*EASM=\"DVD\",1,1,8,\"Power\",\"Chapter\",\"Play\",\"Volume\",\"Menu\",\"Display\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<8; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<8; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[7])
	{
		printf("The user has quitted from DVD mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the DVD player \n");
				else
					printf("Error on turning on/off DVD player! Please check if the DVD player's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user has entered the chapter choice mode \n");
				sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
				ret_code = put_command (command, answer, sizeof (answer), 7, 0);
				win=0;
			    char *location=NULL;
				while (!win)
			    {	
					ret_code = put_command ("", answer, sizeof (answer), 5,0);
					location = strstr(answer, "*EAII: 7,");
					win = (NULL != strstr (answer, "*EAII: 7,"));
					}
				char outputint[3];
				flush (outputint,3);
	  			outputint[0]=answer[location-answer+9];
				outputint[1]=answer[location-answer+10];
				outputint[2]='\0';
				if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
					//system(instruct);
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto DVD;
					}
				else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
				{
					sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
					//system(instruct);
					printf("The user has chosen chapter %s \n", outputint);
					goto DVD;
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,3,\"Play by key?\",\"Play by menu?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else if (ans_select[0])
				{
					play_key:
					sprintf (command, "AT*EASM=\"Play\",1,1,10,\"Play\",\"Stop\",\"Pause/step\",\"Fast backward?\",\"Fast forward?\",\"Last chapter?\",\"Next chapter?\",\"Repeat?\",\"Eject?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (b=0; b<10; b++)
						ans_select[b]=0;
					choice1=1;
					while (choice1)
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						for (c=0; c<10; c++)
						{
							sprintf (buffer, "*EAMI: %d", c+1);
							ans_select[c]=(NULL != strstr (answer, buffer));
							if (ans_select[c]==1)
							{
								choice1=0;
								break;
								}
							}
						}
					if (ans_select[9])
						goto play;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
							//system(instruct);
							printf("The DVD is playing \n");
							goto play;
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
							//system(instruct);
							printf("The DVD is stopped \n");
							goto play;
							}
						else if (ans_select[2])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
							//system(instruct);
							printf("The DVD is paused \n");
							goto play;
							}
						else if (ans_select[3])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
							//system(instruct);
							printf("The DVD is fast-backwarding \n");
							goto play;
							}
						else if (ans_select[4])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
							//system(instruct);
							printf("The DVD is fast-forwarding \n");
							goto play;
							}
						else if (ans_select[5])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s last", remote);
							//system(instruct);
							printf("The DVD is playing the previous chapter \n");
							goto play;
							}
						else if (ans_select[6])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s next", remote);
							//system(instruct);
							printf("The DVD is playing next chapter \n");
							goto play;
							}
						else if (ans_select[7])
						{
							Repeat:
							sprintf (command, "AT*EASM=\"Repeat\",1,1,3,\"A-B?\",\"1/All?\",\"quit\",\r");
							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
							for (a=0; a<3; a++)
								ans_select[a]=0;
							while (!ans_select[0] && !ans_select[1] && !ans_select[2])
							{
								ret_code = put_command ("", answer, sizeof (answer), 5, 0);
								ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
								ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
								ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
								}
							if (ans_select[2])
								goto play;
							else if (ans_select[0])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat1", remote);
								//system(instruct);
								printf("The DVD is repeating in A-B mode \n");
								goto Repeat;
								}
							else if (ans_select[1])
							{ 
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s repeat2", remote);
								//system(instruct);
								printf("The DVD is displaying in 1/all mode \n");
								goto Repeat;
								}
							}
						else if (ans_select[8])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s eject", remote);
							//system(instruct);
							printf("The DVD is ejected out \n");
							goto play;
							}
						}
					}
				else if (ans_select[1])
				{
					printf("The user has entered play menu setting mode \n");
					play_menu:
					sprintf (command, "AT*EASM=\"Play menu\",1,1,2,\"Set\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					ans_select[0]=0;
					ans_select[1]=0;
					while (!ans_select[0] && !ans_select[1])
					{
						ret_code=put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						}
					if (ans_select[1])
						goto play;
					else
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
						//system(instruct);
						printf("The user is modifying the menu\n");
						select:
						sprintf(command, "AT*EASM=\"Choice\",1,1,10,\"up\",\"down\",\"left\",\"right\",\"chapter\",\"enter\",\"clear\",\"next page\",\"last page\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (f=0; f<10; f++)
							ans_select[f]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (g=0; g<10; g++)
							{
								sprintf (buffer, "*EAMI: %d", g+1);
								ans_select[g]=(NULL != strstr (answer, buffer));
								if (ans_select[g]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[9])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s schedule", remote);
							//system(instruct);
							printf("The user has set the play menu \n");
							goto play_menu;
							}
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								goto select;
								}
							else if (ans_select[4])
							{
								sprintf (command, "AT*EAID=7,1,\"Chapter\",\"Chapter?\",0,99,\r");
								ret_code = put_command (command, answer, sizeof (answer), 7, 0);
								win=0;
							    char *location=NULL;
								while (!win)
							    {	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 7,");
									win = (NULL != strstr (answer, "*EAII: 7,"));
									}
								char outputint[3];
								flush (outputint,3);
					  			outputint[0]=answer[location-answer+9];
	  							outputint[1]=answer[location-answer+10];
								outputint[2]='\0';
								if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
									//system(instruct);
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
								else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
								{
									sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
									//system(instruct);
									printf("The user has chosen chapter %s \n", outputint);
									goto select;
									}
							    }
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has entered a chapter in the play list \n");
								goto play_menu;
								}
							else if (ans_select[6])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s clear", remote);
								//system(instruct);
								printf("The user has cleared an item \n");
								goto play_menu;
								}
							else if (ans_select[7])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
								//system(instruct);
								printf("The list has been switched to next page \n");
								goto play_menu;
								}
							else if (ans_select[8])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
								//system(instruct);
								printf("The list has been switched to previous page \n");
								goto play_menu;
								}
							}
						}
					}
				break;
			case 4:
				printf("The user has entered volume mode \n");
				vol:
				sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"increase vol?\",\"decrease vol?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
                    goto vol;
					}
				break;
			case 5:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered menu setting mode \n");
				menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (d=0; d<6; d++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (e=0; e<6; e++)
					{
						sprintf (buffer, "*EAMI: %d", e+1);
						ans_select[e]=(NULL != strstr (answer, buffer));
						if (ans_select[e]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto DVD;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						goto menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has chosen an item\n");
						goto DVD;
						}
				}
				break;
			case 6:
				printf("The user has entered display setting mode \n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,9,\"Display?\",\"Zoom?\",\"Browse?\",\"Signal mode?\",\"Caption?\",\"Angle?\",\"Channel?\",\"Title?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<9; a++)
					ans_select[a]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (b=0; b<9; b++)
					{
						sprintf (buffer, "*EAMI: %d", b+1);
						ans_select[b] = (NULL != strstr (answer, buffer));
						if (ans_select[b]==1)
						{
							choice1=0;
							con=b+1;
							break;
							}
						}
					}
				if (ans_select[8])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s display", remote);
						//system(instruct);
						printf("The user has chosen a display format \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s zoom", remote);
						//system(instruct);
						printf("The user has chosen a zooming aspects \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s browse", remote);
						//system(instruct);
						printf("The user has chosen to browse \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s signal_mode", remote);
						//system(instruct);
						printf("The user has searched a signal mode\n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s caption", remote);
						//system(instruct);
						printf("The user has chosen (not) to show caption\n");
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s angle", remote);
						//system(instruct);
						printf("The user has chosen a display angle \n");
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s channel", remote);
						//system(instruct);
						printf("The user has chosen a display channel \n");
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s title", remote);
						//system(instruct);
						printf("The user has chosen to show a title \n");
						}
                    goto display;
					}
				break;
			case 7:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Setup\",\"Silent\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto DVD;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s setup", remote);
						//system(instruct);
						printf("The user has entered setup menu \n");
						setup:
						sprintf(command, "AT*EASM=\"Setup\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"enter\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto setup;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The user has chosen an item\n");
								goto others;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s silent", remote);
						//system(instruct);
						printf("The user has made the DVD player silently \n");
						}
                    goto others;
					}
				break;
			default:
				break;
			}
		goto DVD;
		}
	}

void VCRcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int win;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered VCR mode \n");
	VCR:
	sprintf (command, "AT*EASM=\"VCR\",1,1,6,\"Power\",\"Channel\",\"Play\",\"Recording\",\"Others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<6; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<6; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[5])
	{
		printf("The user has quitted from VCR mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
				/*system(instruct);
				if (!system(instruct))
					printf("The user has turned on/off the VCR \n");
				else
					printf("Error on turning on/off VCR! Please check if the VCR's power is in standby mode \n");*/
				break;
			case 2:
				printf("The user wishes to change recording channel\n");
				channel_choice1:
				sprintf (command, "AT*EASM=\"Channel\",1,1,3,\"Change by key?\",\"Change by no.?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					goto VCR;
				else if (ans_select[0])
				{
					channel_choice2:
					sprintf (command, "AT*EASM=\"Volume\",1,1,3,\"up channel?\",\"down channel?\",\"quit\",\r");
					ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					for (a=0; a<3; a++)
						ans_select[a]=0;
					while (!ans_select[0] && !ans_select[1] && !ans_select[2])
					{
						ret_code = put_command ("", answer, sizeof (answer), 5, 0);
						ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
						ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
						ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
						}
					if (ans_select[2])
						goto channel_choice1;
					else
					{
						if (ans_select[0])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
							//system(instruct);
							}
						else if (ans_select[1])
						{
							sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
							//system(instruct);
							}
						goto channel_choice2;
						}
					}
				else if (ans_select[1])
				{
					sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
					ret_code = put_command (command, answer, sizeof (answer), 7, 0);
					win=0;
				    char *location=NULL;
					while (!win)
				    {	
						ret_code = put_command ("", answer, sizeof (answer), 5,0);
						location = strstr(answer, "*EAII: 7,");
						win = (NULL != strstr (answer, "*EAII: 7,"));
						}
					char outputint[3];
					flush (outputint,3);
		  			outputint[0]=answer[location-answer+9];
					outputint[1]=answer[location-answer+10];
					outputint[2]='\0';
					if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
						//system(instruct);
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
						//system(instruct);
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
						//system(instruct);
						printf("The user has chosen channel %s \n", outputint);
						goto VCR;
						}
					else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
						//system(instruct);
						printf("The user has chosen channel %s \n", outputint);
						goto VCR;
						}
					}
				break;
			case 3:
				printf("The user has entered play mode \n");
				play:
				sprintf (command, "AT*EASM=\"Play\",1,1,6,\"Play\",\"Stop/eject?\",\"Pause\",\"Fast backward?\",\"Fast forward?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (b=0; b<6; b++)
					ans_select[b]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (c=0; c<6; c++)
					{
						sprintf (buffer, "*EAMI: %d", c+1);
						ans_select[c]=(NULL != strstr (answer, buffer));
						if (ans_select[c]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[5])
					goto VCR;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s play", remote);
						//system(instruct);
						printf("The user has chosen to play \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s stop", remote);
						//system(instruct);
						printf("The user has chosen to stop \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pause/step", remote);
						//system(instruct);
						printf("The user has chosen to pause/play in step \n");
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s fbw", remote);
						//system(instruct);
						printf("The user has chosen to fast-backward \n");
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s ffw", remote);
						//system(instruct);
						printf("The user has chosen to fast-forward \n");
						}
					goto play;
					}	
				break;
			case 4:
				printf("The user has entered recording mode\n");
				record:
				sprintf (command, "AT*EASM=\"Recording\",1,1,3,\"By key?\",\"By setting time?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s record", remote);
						//system(instruct);
						printf("The VCR is starting recording\n");
						}
					else if (ans_select[1])
					{
						printf("The user is setting the recording information\n");
						record_set:
						sprintf (command, "AT*EASM=\"Record setting\",1,1,3,\"Channel\",\"Time\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (a=0; a<3; a++)
							ans_select[a]=0;
						while (!ans_select[0] && !ans_select[1] && !ans_select[2])
						{
							ret_code = put_command ("", answer, sizeof (answer), 5, 0);
							ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
							ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
							ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
							}
						if (ans_select[2])
							break;
						else if(ans_select[0])
						{
							printf("The user is choosing channel for recording\n");
							sprintf (command, "AT*EAID=7,1,\"Channel\",\"Channel?\",0,99,\r");
							ret_code = put_command (command, answer, sizeof (answer), 7, 0);
							win=0;
							char *location=NULL;
							while (!win)
							{	
								ret_code = put_command ("", answer, sizeof (answer), 5,0);
								location = strstr(answer, "*EAII: 7,");
								win = (NULL != strstr (answer, "*EAII: 7,"));
								}
							char outputint[3];
							flush (outputint,3);
					  		outputint[0]=answer[location-answer+9];
	  						outputint[1]=answer[location-answer+10];
							outputint[2]='\0';
							if ((atoi(outputint)>=10) && (atoi(outputint)<=99))
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s 10+", remote);
								//system(instruct);
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)/10);
								//system(instruct);
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %d", remote, atoi(outputint)%10);
								//system(instruct);
								printf("The user has chosen channel %s \n", outputint);
								goto record_set;
								}
							else if ((atoi(outputint)>=0) && (atoi(outputint)<=9))
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s %s", remote, outputint);
								//system(instruct);
								printf("The user has chosen channel %s \n", outputint);
								goto record_set;
								}
							}
						else if(ans_select[1])
						{
							printf("The user is setting record time\n");
							rec_time:
							while (1)
					  		{
								sprintf (command, "AT*EAID=9,1,\"Start Date\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	  							win=0;
								char *location=NULL;
	  							while (!win)
								{	
									ret_code = put_command ("", answer, sizeof (answer), 5,0);
									location = strstr(answer, "*EAII: 9,");
									win = (NULL != strstr (answer, "*EAII: 9,"));
									}
								char year[3];
								flush (year,3);
					  			year[0]=answer[location-answer+10];
	  							year[1]=answer[location-answer+11];
					  			year[2]='\0';
	  							char month[3];
								flush (month,3);
	  							month[0]=answer[location-answer+13];
					  			month[1]=answer[location-answer+14];
	  							month[2]='\0';
	  							char day[3];
								flush (day,3);
	  							day[0]=answer[location-answer+16];
					  			day[1]=answer[location-answer+17];
	  							day[2]='\0';
	  							printf ("%s\n",year);
	  							printf ("%s\n",month);
					  			printf ("%s\n",day);	
								printf ("Start Date (yy/mm/dd): %s/%s/%s\n", year, month, day);
								win=0;
								location=NULL;
                                sprintf (command, "AT*EAID=10,1,\"Start Time\"\r");
                                ret_code = put_command (command, answer, sizeof (answer), 5, 0);
                                while (!win)
                                {
                                    ret_code = put_command ("", answer, sizeof (answer), 20, 0);
                                    location = strstr(answer, "*EAII: 10,");
                                    win = (NULL != strstr (answer, "*EAII: 10,"));
									}
                                printf("%s\n", answer);
                                char hour[3];
                                flush (hour,3);
                                //hour[0]=answer[location-answer+11];
                                //hour[1]=answer[location-answer+12];
								hour[0]='1';
								hour[1]=answer[location-answer+11];
                                hour[2]='\0';
                                char min[3];
                                flush (min,3);
                                min[0]=answer[location-answer+13];
                                min[1]=answer[location-answer+14];
                                min[2]='\0';
                                printf ("%s\n", hour);
                                printf ("%s\n", min);
                                printf ("Start Time (hh:mm): %s:%s\n", hour, min);
                                win=0;
                                location=NULL;
					  			sprintf (command, "AT*EAID=9,1,\"End Date\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
					  			while (!win)
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									location = strstr(answer, "*EAII: 9,");
									win = (NULL != strstr (answer, "*EAII: 9,"));
									}
					  			char end_year[3];
								flush (end_year,3);
	  							end_year[0]=answer[location-answer+10];
	  							end_year[1]=answer[location-answer+11];
	  							end_year[2]='\0';
					  			char end_month[3];
								flush (end_month,3);
					  			end_month[0]=answer[location-answer+13];
					  			end_month[1]=answer[location-answer+14];
	  							end_month[2]='\0';
	  							char end_day[3];
								flush (end_day,3);
	  							end_day[0]=answer[location-answer+16];
					  			end_day[1]=answer[location-answer+17];
	  							end_day[2]='\0';
					  			printf("%s\n",end_year);
	  							printf("%s\n",end_month);
					  			printf("%s\n",end_day);
								printf("End Date (yy/mm/dd): %s/%s/%s\n", end_year, end_month, end_day);
								win=0;
								location=NULL;
								sprintf (command, "AT*EAID=10,1,\"End Time\"\r");
	  							ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	  							while (!win)
								{
									ret_code = put_command ("", answer, sizeof (answer), 20, 0);
									location = strstr(answer, "*EAII: 10,");
									win = (NULL != strstr (answer, "*EAII: 10,"));
									}
								printf("%s",answer);
								char end_hour[3];
								flush (end_hour,3);
								end_hour[0]='1';
	  							//end_hour[0]=answer[location-answer+11];
					  			end_hour[1]=answer[location-answer+11];
	  							end_hour[2]='\0';
	  							char end_min[3];
								flush (end_min,3);
	  							end_min[0]=answer[location-answer+13];
	  							end_min[1]=answer[location-answer+14];
	  							end_min[2]='\0';
	  							printf("%s\n",end_hour);
	  							printf("%s\n",end_min);
								printf("End Time (hh:mm): %s:%s\n", end_hour, end_min);							
								goto record_set;
								}
							}
						}
					}
				break;
			case 5:
				printf("The user enters other mode\n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,3,\"Menu\",\"Guide\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<3; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has entered menu setting mode\n");
						vcr_menu:
						sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"select\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto vcr_menu;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s select", remote);
								//system(instruct);
								printf("The user has selected an item in menu\n");
								goto VCR;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s guide", remote);
						//system(instruct);
						printf("The user has entered guide mode\n");
						vcr_guide:
						sprintf(command, "AT*EASM=\"Menu\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"select\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (d=0; d<6; d++)
							ans_select[d]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (e=0; e<6; e++)
							{
								sprintf (buffer, "*EAMI: %d", e+1);
								ans_select[e]=(NULL != strstr (answer, buffer));
								if (ans_select[e]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upchannel", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downchannel", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
								//system(instruct);
								goto vcr_guide;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s guide", remote);
								//system(instruct);
								goto VCR;
								}
							}
						}
					}
				break;
			default:
				break;
			}
		goto VCR;
		}
	}

void projectorcontrol(char remote[])
{
	char instruct[1024];
	int item_choice1=0;
	int ans_select[100];
	int con;
	int a,b,c,d,e,f,g,h,i;
	int choice1;
	int choice2;
	int menu_count;
	//int chapter_count=0;
	printf("The user has entered projector mode \n");
	projector:
	sprintf (command, "AT*EASM=\"Projector\",1,1,7,\"Power\",\"menu\",\"input\",\"Display\",\"volume\",\"others\",\"quit\",\r");
	ret_code = put_command (command, answer, sizeof (answer), 5, 0);
	for (a=0; a<7; a++)
		ans_select[a]=0;
	choice1=1;
	while (choice1)
	{
		ret_code=put_command ("", answer, sizeof (answer), 5, 0);
		for (b=0; b<7; b++)
		{
			sprintf (buffer, "*EAMI: %d", b+1);
			ans_select[b] = (NULL != strstr (answer, buffer));
			if (ans_select[b]==1)
			{
				choice1=0;
				con=b+1;
				break;
				}
			}
		}
	if (ans_select[6])
	{
		printf("The user has quitted from projector mode \n");
		return;
		}
	else
	{
		switch (con)
		{
			case 1:
				printf("The user has entered the power mode\n");
				power:
				sprintf (command, "AT*EASM=\"Power\",1,1,3,\"Power\",\"Standby\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<3; c++)
					ans_select[c]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					}
				if (ans_select[2])
					break;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s power", remote);
						//system(instruct);
						if (!system(instruct))
							printf("The user has turned on/off the projector \n");
						else
							printf("Error on turning on/off projector!\n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s standby", remote);
						//system(instruct);
						if (!system(instruct))
							printf("The user has turned the projector to standby mode\n");
						else
							printf("Error on turning the projector to standby mode!\n");
						}
					goto power;
					}
				break;
			case 2:
				sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
				//system(instruct);
				printf("The user has entered the power mode\n");
				projector_menu:
				sprintf(command, "AT*EASM=\"Menu\",1,1,9,\"up\",\"down\",\"left\",\"right\",\"enter\",\"reset\",\"menu\",\"undo\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<9; c++)
					ans_select[d]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<9; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[8])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
						//system(instruct);
						goto projector_menu;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
						//system(instruct);
						printf("The user has selected an item in menu\n");
						goto projector_menu;
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s reset", remote);
						//system(instruct);
						printf("The user has reset all settings to default one\n");
						goto projector_menu;
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s menu", remote);
						//system(instruct);
						printf("The user has quitted from menu\n");
						goto projector;
						}
					else if (ans_select[7])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s undo", remote);
						//system(instruct);
						printf("The user has cancelled the setting\n");
						goto projector;
						}
					}
				break;
			case 3:
				printf("The user has entered input mode\n");
				input:
				sprintf (command, "AT*EASM=\"Input\",1,1,8,\"mode 1\",\"mode 2\",\"mode 3\",\"mode 4\",\"mode 5\",\"Computer\",\"Video\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<7; c++)
					ans_select[c]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<7; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[7])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input1", remote);
						//system(instruct);
						printf("The user has chosen input mode 1\n");
						goto input;
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input2", remote);
						//system(instruct);
						printf("The user has chosen input mode 2\n");
						goto input;
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input3", remote);
						//system(instruct);
						printf("The user has chosen input mode 3\n");
						goto input;
						}
					else if (ans_select[3])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input4", remote);
						//system(instruct);
						printf("The user has chosen input mode 4\n");
						goto input;
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s input5", remote);
						//system(instruct);
						printf("The user has chosen input mode 5\n");
						goto input;
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s computer", remote);
						//system(instruct);
						printf("The user has chosen input from computer \n");
						goto input;
						}
					else if (ans_select[6])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s video", remote);
						//system(instruct);
						printf("The user has chosen input from video\n");
						goto input;
						}
					}
				break;
			case 4:
				printf("The user has entered the display mode\n");
				display:
				sprintf (command, "AT*EASM=\"Display\",1,1,7,\"Image\",\"Keystone\",\"Auto\",\"PinP\",\"Freeze\",\"Aspect\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (c=0; c<7; c++)
					ans_select[c]=0;
				choice1=1;
				while (choice1)
				{
					ret_code=put_command ("", answer, sizeof (answer), 5, 0);
					for (d=0; d<7; d++)
					{
						sprintf (buffer, "*EAMI: %d", d+1);
						ans_select[d]=(NULL != strstr (answer, buffer));
						if (ans_select[d]==1)
						{
							choice1=0;
							break;
							}
						}
					}
				if (ans_select[6])
					goto projector;
				else
				{
					if (ans_select[0])
					{
						printf("The user has entered image mode\n");
						image:
						sprintf (command, "AT*EASM=\"Image\",1,1,7,\"Focus\",\"Zoom\",\"Magnify\",\"Position\",\"RGB\",\"Blank\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto display;			
						else
						{
							if (ans_select[0])
							{
								printf("The user is changing focus\n");
								focus:
								sprintf (command, "AT*EASM=\"Focus\",1,1,3,\"increase?\",\"decrease?\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								while (!ans_select[0] && !ans_select[1] && !ans_select[2])
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
									ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
									ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upfocus", remote);
										//system(instruct);
										printf("The user has increased the focus\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downfocus", remote);
										//system(instruct);
										printf("The user has decreased the focus\n");
										}
									goto focus;
									}
								}
							else if (ans_select[1])
							{
								printf("The user is changing the zooming level\n");
								zoom:
								sprintf (command, "AT*EASM=\"zoom\",1,1,3,\"increase?\",\"decrease?\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								while (!ans_select[0] && !ans_select[1] && !ans_select[2])
								{
									ret_code = put_command ("", answer, sizeof (answer), 5, 0);
									ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
									ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
									ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upfocus", remote);
										//system(instruct);
										printf("The user has zoomed in\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downfocus", remote);
										//system(instruct);
										printf("The user has zoomed out\n");
										}
									goto zoom;
									}
								}
							else if (ans_select[2])
							{
								printf("The user is changing the magnification\n");
								magnify:
								sprintf (command, "AT*EASM=\"magnify\",1,1,3,\"up\",\"down\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<3; g++)
									ans_select[g]=0;
								choice1=1;
								while (choice1)
								{
									ret_code=put_command ("", answer, sizeof (answer), 5, 0);
									for (h=0; h<3; h++)
									{
										sprintf (buffer, "*EAMI: %d", h+1);
										ans_select[h]=(NULL != strstr (answer, buffer));
										if (ans_select[h]==1)
										{
											choice1=0;
											break;
											}
										}
									}
								if (ans_select[2])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
										//system(instruct);
										printf("The user has magnified the display\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
										//system(instruct);
										printf("The user has made the display smaller\n");
										}
									goto magnify;
									}
								}
							else if (ans_select[3])
							{
								printf("The user is changing the display's position\n");
								position:
								sprintf (command, "AT*EASM=\"position\",1,1,5,\"up\",\"down\",\"left\",\"right\",\"quit\",\r");
								ret_code = put_command (command, answer, sizeof (answer), 5, 0);
								for (g=0; g<5; g++)
									ans_select[g]=0;
								choice1=1;
								while (choice1)
								{
									ret_code=put_command ("", answer, sizeof (answer), 5, 0);
									for (h=0; h<5; h++)
									{
										sprintf (buffer, "*EAMI: %d", h+1);
										ans_select[h]=(NULL != strstr (answer, buffer));
										if (ans_select[h]==1)
										{
											choice1=0;
											break;
											}
										}
									}
								if (ans_select[4])
									goto image;
								else
								{
									if (ans_select[0])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
										//system(instruct);
										printf("The display has been shifted up\n");
										}
									else if (ans_select[1])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
										//system(instruct);
										printf("The display has been shifted down\n");
										}
									else if (ans_select[2])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
										//system(instruct);
										printf("The display has been shifted left\n");
										}
									else if (ans_select[3])
									{
										sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
										//system(instruct);
										printf("The display has been shifted right\n");
										}
									goto position;
									}
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s rgb", remote);
								//system(instruct);
								printf("The user has changed the display in rgb mode\n");
								goto image;
								}
							else if (ans_select[5])
							{	
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s blank", remote);
								//system(instruct);
								printf("The display has been blanked\n");
								goto image;
								}
							}
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s keystone", remote);
						//system(instruct);
						printf("The user has entered keystone mode\n");
						keystone:
						sprintf (command, "AT*EASM=\"Keystone\",1,1,7,\"up\",\"down\",\"left\",\"right\",\"keystone\",\"undo\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto display;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The user has increased the level of the keystone\n");
								goto keystone;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The user has decreased the level of the keystone\n");
								goto keystone;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The user has changed the direction of keystone\n");
								goto keystone;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The user has changed the direction of keystone\n");
								goto keystone;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s keystone", remote);
								//system(instruct);
								printf("The user has closed the keystone dialog\n");
								goto display;
								}
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s undo", remote);
								//system(instruct);
								printf("The user has cleared the keystone change\n");
								goto display;
								}
							}
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s auto", remote);
						//system(instruct);
						printf("The user has chosen auto position mode\n");
						goto display;	
						}
					else if (ans_select[3])
					{
						printf("The user has chosen Picture-in-picture mode\n");
						pinp:
						sprintf (command, "AT*EASM=\"PinP\",1,1,6,\"up\",\"down\",\"left\",\"right\",\"PinP\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<6; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<6; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[5])
							goto image;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The user has switching the images\n");
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The user has switching the images\n");
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The user has changed image position\n");
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The user has changed image position\n");
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s pinp", remote);
								//system(instruct);
								printf("The sub image disappeared\n");
								}
							goto pinp;
							}
						}
					else if (ans_select[4])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s freeze", remote);
						//system(instruct);
						printf("The display is freezed\n");
						goto display;	
						}
					else if (ans_select[5])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s aspect", remote);
						//system(instruct);
						printf("The user has changed the aspect\n");
						goto display;	
						}
					}
				break;
			case 5:
				printf("The user has entered volume mode \n");
				volume:
				sprintf (command, "AT*EASM=\"Volume\",1,1,4,\"increase vol?\",\"decrease vol?\",\"mute?\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<4; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					goto projector;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s upvol", remote);
						//system(instruct);
						printf("The user has increased volume\n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s downvol", remote);
						//system(instruct);
						printf("The user has decreased volume \n");
						}
					else if (ans_select[2])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s mute", remote);
						//system(instruct);
						printf("The projector was set to be silent \n");
						}
                    goto volume;
					}
				break;
			case 6:
				printf("The user has entered others mode \n");
				others:
				sprintf (command, "AT*EASM=\"Others\",1,1,4,\"search\",\"laser\",\"mouse control\",\"quit\",\r");
				ret_code = put_command (command, answer, sizeof (answer), 5, 0);
				for (a=0; a<4; a++)
					ans_select[a]=0;
				while (!ans_select[0] && !ans_select[1] && !ans_select[2] && !ans_select[3])
				{
					ret_code = put_command ("", answer, sizeof (answer), 5, 0);
					ans_select[0]=(NULL!=strstr(answer, "*EAMI: 1"));
					ans_select[1]=(NULL!=strstr(answer, "*EAMI: 2"));
					ans_select[2]=(NULL!=strstr(answer, "*EAMI: 3"));
					ans_select[3]=(NULL!=strstr(answer, "*EAMI: 4"));
					}
				if (ans_select[3])
					goto projector;
				else
                {
					if (ans_select[0])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s search", remote);
						//system(instruct);
						printf("The projector is searching..... \n");
						}
					else if (ans_select[1])
					{
						sprintf(instruct, "/usr/local/irtrans/irclient localhost %s laser", remote);
						//system(instruct);
						printf("The projector is changed into laser mode \n");
						}				
					else if (ans_select[2])
					{
						printf("The user has entered mouse mode \n");
						mouse:
						sprintf (command, "AT*EASM=\"Mouse control\",1,1,7,\"up\",\"down\",\"left\",\"right\",\"enter\",\"reset\",\"quit\",\r");
						ret_code = put_command (command, answer, sizeof (answer), 5, 0);
						for (e=0; e<7; e++)
							ans_select[e]=0;
						choice1=1;
						while (choice1)
						{
							ret_code=put_command ("", answer, sizeof (answer), 5, 0);
							for (f=0; f<7; f++)
							{
								sprintf (buffer, "*EAMI: %d", f+1);
								ans_select[f]=(NULL != strstr (answer, buffer));
								if (ans_select[f]==1)
								{
									choice1=0;
									break;
									}
								}
							}
						if (ans_select[6])
							goto others;
						else
						{
							if (ans_select[0])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s up", remote);
								//system(instruct);
								printf("The cursor is moving upward \n");
								goto mouse;
								}
							else if (ans_select[1])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s down", remote);
								//system(instruct);
								printf("The cursor is moving downward \n");
								goto mouse;
								}
							else if (ans_select[2])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s left", remote);
								//system(instruct);
								printf("The cursor is moving left \n");
								goto mouse;
								}
							else if (ans_select[3])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s right", remote);
								//system(instruct);
								printf("The cursor is moving right \n");
								goto mouse;
								}
							else if (ans_select[4])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s enter", remote);
								//system(instruct);
								printf("The cursor has chosen a point \n");
								goto mouse;
								}
							else if (ans_select[5])
							{
								sprintf(instruct, "/usr/local/irtrans/irclient localhost %s reset", remote);
								//system(instruct);
								printf("The user has right-clicked the mouse \n");
								goto mouse;
								}
							}
						}
					}
				break;
			default:
				break;
			}
		goto projector;
		}
	}


--0-1102683115-1111585346=:2667
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



--0-1102683115-1111585346=:2667
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

--0-1102683115-1111585346=:2667--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
