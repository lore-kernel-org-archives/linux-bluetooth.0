Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 30 May 2006 08:30:13 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E5137@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stutteringsound	from	WM5.0
	AKU2.0
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

Brad

Yesterday I tried to set the channel and speed settings manualy. Set
Channels = 2 and speed 36000/44100/48000 ... but nothing changes. 

Hier is what i did ...


unsigned char audio_buffer[BUF_SIZE];
int speed, channels;
int my_speed, my_channels; // guido

int adjustsound()
{
	my_speed = 48000;
	my_channels = 2;
	if(ioctl(audio_fd,SNDCTL_DSP_CHANNELS,&my_channels)==-1) { //
guido
		perror("\nioctl no. 2\n");
		exit(1);
	}

	if(ioctl(audio_fd,SNDCTL_DSP_SPEED,&my_speed)==-1) {   / guido
		perror("\nioctl no. 3\n");
		exit(1);
	}

	return 1;
}


Still have the same problem :`(


Guido



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
