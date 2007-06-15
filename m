Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 15 Jun 2007 18:09:03 +0200
MIME-Version: 1.0
Message-Id: <200706151809.04115.fernando@bluexare.org>
Subject: [Bluez-devel] Problems with my own inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,
I have an application that works with the bluetooth, scanning and sending =

content with other devices..., and now, when I'm trying to make irt work in =

other distribution, it fails.

And I don't know what it is wrong.
The problem is in my Inquiry function (this is a function to make an inquir=
y =

and check the result for not to repeat devices...).
The hci_inquiry function makes an inquiry, and the value Max_Num_Responses =
is =

the number of responses, and I need the number of different devices found. =

Because of that, I have done this inquiry:

int inquiry (char *aux_mac[], int num_dev, int duration){
	struct timeval time;
	long time_orig, time_dest;
	int i, sock;
	unsigned char buf[HCI_MAX_FRAME_SIZE];
	struct sockaddr_hci addr;
	struct hci_filter filter;
	unsigned char cmd[] =3D {0x01, 0x01, 0x04, 0x05, 0x33, 0x8B, 0x9E, 0x08, 0=
x0A};
	int cmd_len =3D sizeof(cmd);
	int encore =3D 1, num_exec=3D 0;
	char *mac=3D (char *)malloc(18);
	int terminado=3D 0, encontrados=3D 0;
	=

	sock =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
	if (sock=3D=3D -1)
		return -1;
	hci_filter_clear(&filter);
	hci_filter_set_ptype(HCI_EVENT_PKT, &filter);
	hci_filter_set_event(EVT_CMD_STATUS, &filter);
	hci_filter_set_event(EVT_INQUIRY_RESULT, &filter);
	hci_filter_set_event(EVT_INQUIRY_COMPLETE, &filter);

	if (setsockopt(sock, SOL_HCI, HCI_FILTER, &filter, sizeof(filter))=3D=3D -=
1)
		return -1;

	addr.hci_family =3D AF_BLUETOOTH;
//Esto coge el segundo bluetooth si est=E1 a 1
	addr.hci_dev =3D 0;

	if (bind(sock, (struct sockaddr *)&addr, sizeof(addr))=3D=3D -1){
		debug_printf(D_PRUEBA,"Error al hacer bind del inquiry\n");
		return -1;
	}
	gettimeofday (&time, NULL);
	time_orig=3D time.tv_sec;
	while (!terminado){				//No se por que, este inquiry solo hace 10 escaneos=
, =

asi que vuelvo a llamarlo hasta
		if (send (sock, cmd, cmd_len, 0)=3D=3D -1){	//que cumplo con los disposit=
ivos =

deseados
			debug_printf(D_PRUEBA,"Error al hacer send del inquiry\n");
			return -1;
		}
printf ("Envio un inquiry\n");
		do {
			memset (buf, 0, sizeof(buf));
			if (recv (sock, buf, sizeof(buf), 0)=3D=3D -1){
				debug_printf(D_PRUEBA,"Error al hacer receive del inquiry\n");
				return -1;
			}
printf ("buf[1]=3D %d;   EVT_CMD_STATUS=3D %d; EVT_INQUIRY_RESULT=3D %d; =

EVT_INQUIRY_COMPLETE=3D%d\n", buf[1], EVT_CMD_STATUS, EVT_INQUIRY_RESULT, =

EVT_INQUIRY_COMPLETE);
			switch (buf[1]) {
				case EVT_CMD_STATUS:
printf ("Entro en EVT_CMD; %d\n", buf[1]);
					if (buf[3]) {
						//debug_printf(D_PRUEBA,"Error\n");
						encore =3D 0;
						num_exec=3D 255;
					}
					break;
				case EVT_INQUIRY_RESULT:
				case EVT_INQUIRY_RESULT_WITH_RSSI:
printf ("Entro en EVT_INQUIRY_RESULT; %d\n", buf[1]);
					sprintf (mac, "%02x:%02x:%02x:%02x:%02x:%02x", buf[9], buf[8], buf[7], =

buf[6], buf[5], buf[4]);
					for (i=3D 0; i< 18; i++)
						if (!(isdigit (mac[i])) && !(strcmp (&mac[i], ":")=3D=3D 0))
							mac[i]=3D toupper (mac[i]);
					if (!mac_existe (aux_mac, encontrados, mac)){
						strcpy (aux_mac[encontrados], mac);
						encontrados++;
					}
					break;
				case EVT_INQUIRY_COMPLETE:
printf ("Entro en EVT_INQUIRY_COMPLETE; %d\n", buf[1]);
					encore=3D 0;
					num_exec+=3D 1;
					break;
				default:
printf ("Entro en \"default\"; %d\n", buf[1]);
					break;
			}
			gettimeofday (&time, NULL);
			time_dest=3D time.tv_sec;
			if (encontrados=3D=3D num_dev || ((time_dest- time_orig)> duration)){
				terminado=3D 1;
				encore=3D 0;
			}
		} while (encore);
		encore=3D 1;
	}

	close (sock);
	return encontrados;
}

int mac_existe (char *aux_mac[], int encontrados, char *mac){
	int i;
	for (i=3D 0; i< encontrados; i++){
		if (strcmp (aux_mac[i], mac)=3D=3D 0)
			return 1;
	}
	return 0;
}


In my PC, a Ubuntu dapper (6.06), the output, a valid output is:
(first, search for 1 device, then for 2, then for 3...)
#Buscando max 1 dispositivos
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
#Encontrados 1 dispositivos
#Buscando max 2 dispositivos
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
#Encontrados 2 dispositivos
#Buscando max 3 dispositivos
Envio un inquiry
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 2;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_RESULT; 2
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15

This is a normal work, whit INQUIRY_RESULT and COMMAND_STATUS, but in the n=
ew =

PC (a debian etch, buiilt by DebianLive) where I want to install the =

application the output is like this:

#Buscando max 1 dispositivos
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
#Encontrados 0 dispositivos
#Buscando max 1 dispositivos
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
Envio un inquiry
buf[1]=3D 15;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; =

EVT_INQUIRY_COMPLETE=3D1
Entro en EVT_CMD; 15
buf[1]=3D 1;   EVT_CMD_STATUS=3D 15; EVT_INQUIRY_RESULT=3D 2; EVT_INQUIRY_C=
OMPLETE=3D1
Entro en EVT_INQUIRY_COMPLETE; 1
#Encontrados 0 dispositivos

All the time the only events that receive are INQUIRY_COMPLETE and =

COMMAND_STATUS, but with hcidump I have seen that really the bluetooth scan=
s =

ok (the only difference with the other system is that the scans are with =

RSSI, and in the OK system are without RSSI).

HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 10
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -29
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -33
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -30
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -33
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -30
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -28
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -31
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:80:5A:46:8A:1E mode 1 clkoffset 0x6b7e class 0x100000 rssi -27
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -26
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:80:5A:46:8A:1E mode 1 clkoffset 0x6b7e class 0x100000 rssi -26
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 10
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a68 class 0x3e0100 rssi -32
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a67 class 0x3e0100 rssi -29
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a67 class 0x3e0100 rssi -36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -29
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:4B:88 mode 0 clkoffset 0x2a67 class 0x3e0100 rssi -32
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -30
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:80:5A:46:8A:1E mode 1 clkoffset 0x6b7e class 0x100000 rssi -26
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -28
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:80:5A:46:8A:1E mode 1 clkoffset 0x6b7e class 0x100000 rssi -26
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:10:60:AE:61:C8 mode 1 clkoffset 0x513f class 0x3e0100 rssi -45
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00



Anybody can help me...?

I haven't no idea why are happening that.

Thanks everybody for reading all the message, i know it's long, jeje.

And sorry for my english,
Fernando Unzu

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
