Return-Path: <cyrus@holtmann.org>
Message-ID: <521C9785.2020205@richardneill.org>
Date: Tue, 27 Aug 2013 13:11:49 +0100
From: Richard Neill <rn214@richardneill.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: hciconfig list commands (patch)
Content-Type: multipart/mixed;
 boundary="------------050302010706060103000906"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050302010706060103000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

I'd like to offer a small patch to tools/hciconfig.c (and the man page).

Currently, running the command "hciconfig hci0 commands" creates a list 
of supported codes and their names in this format[1]. It's rather tricky 
to interpret this format, when trying to discover the command code for a 
particular named action, because both lists are very long, and run 
consecutively rather than concurrently.

My patch adds an extra command ""hciconfig hci0 commands_list", which 
hopefully makes this clearer, emitting output in the format of [2].

I hope this is helpful :-)

If it's necessary to have a legal declaration, then I hereby state for 
the record that I, Richard Neill, wrote the attached code, and I release 
it under the GPL 2+.


[1] output of "hciconfig hci0 commands"
------------------------
Commands: Octet 0  = 0xff (Bit 0 1 2 3 4 5 6 7)
           Octet 1  = 0xff (Bit 0 1 2 3 4 5 6 7)
....
'Inquiry' 'Inquiry Cancel' 'Periodic Inquiry Mode'
'Exit Periodic Inquiry Mode' 'Create Connection' 'Disconnect'
'Add SCO Connection' 'Cancel Create Connection'
'Accept Connection Request' 'Reject Connection Request'
....
------------------------


[2] output of "hciconfig hci0 commands_list"
-------------------------
Byte:   Octet:  Bit:    Command:
0x00     0       0      'Inquiry'
0x01     0       1      'Inquiry Cancel'
0x02     0       2      'Periodic Inquiry Mode'
0x03     0       3      'Exit Periodic Inquiry Mode'
0x04     0       4      'Create Connection'
0x05     0       5      'Disconnect'
0x06     0       6      'Add SCO Connection'
0x07     0       7      'Cancel Create Connection'
....
-------------------------


Best wishes,

Richard


P.S. This is my contribution to bluez, so I hope I'm sending the right 
format to the right place.  If I could do this better, I'd welcome 
feedback off-list.


--------------050302010706060103000906
Content-Type: text/x-patch;
 name="hciconfig.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hciconfig.1.patch"

225a226,228
> .BI commands_list
> Display supported commands in a list format (easier to parse).
> .TP

--------------050302010706060103000906
Content-Type: text/x-patch;
 name="hciconfig.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hciconfig.c.patch"

1119a1120,1155
> static void cmd_commands_list(int ctl, int hdev, char *opt)
> {
> 	uint8_t cmds[64];
> 	char *str;
> 	int i, n, dd;
> 
> 	dd = hci_open_dev(hdev);
> 	if (dd < 0) {
> 		fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
> 						hdev, strerror(errno), errno);
> 		exit(1);
> 	}
> 
> 	if (hci_read_local_commands(dd, cmds, 1000) < 0) {
> 		fprintf(stderr, "Can't read support commands on hci%d: %s (%d)\n",
> 						hdev, strerror(errno), errno);
> 		exit(1);
> 	}
> 
> 	print_dev_hdr(&di);
> 	printf ("\tCommands:\n\tByte:   Octet:  Bit:    Command:\n");
> 	for (i = 0; i < 64; i++) {
> 		if (!cmds[i]){
> 			continue;
> 		}
> 		for (n = 0; n < 8; n++){
> 			if (cmds[i] & (1 << n)){
> 				printf("\t0x%02x    %2d      %2d      '%s'\n",
> 				       (8*i + n), i, n, hci_cmdtostr(8*i + n) ); 
> 			}
> 		}
> 		printf ("\n");
> 	}
> 	hci_close_dev(dd);
> }
> 
1926c1962,1963
< 	{ "commands",	cmd_commands,	0,		"Display supported commands" },
---
> 	{ "commands_list",cmd_commands_list,	0,	"Display supported commands (list format)" },
> 	{ "commands",cmd_commands,	0,		"Display supported commands" },

--------------050302010706060103000906--
