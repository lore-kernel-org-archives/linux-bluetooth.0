Return-Path: <cyrus@holtmann.org>
From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: RE: Headset doesn't work at all (ALSA)
To: linux-bluetooth@vger.kernel.org
Date: Fri, 26 Jun 2009 18:30:30 +0200
References: <200906261122.39383.sojkam1@fel.cvut.cz> <6AC5A55546F64545AE996F8200E3AC4E06B667D1@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <20090626163059.8D44B15C025@imap.feld.cvut.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John Frankish wrote:
> Then I tried:
> 
>>$ aplay -D bluetooth  'rec.wav'
>>Playing WAVE 'rec.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
>>aplay: pcm_write:1528: write error: Connection timed out
> 
>>> does aplay -D plug:bluetooth  rec.wav help?

No, it doesn't help. The corresponding bluetoothd output is:

Jun 26 18:28:50 resox bluetoothd[14098]: Accepted new client connection on unix socket (fd=22)
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_OPEN
Jun 26 18:28:50 resox bluetoothd[14098]: open sco - object=ANY source=ANY destination=00:07:A4:87:E2:EE lock=write
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_OPEN
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 26 18:28:50 resox bluetoothd[14098]: socket(SEQPACKET, SCO): Too many open files (24)
Jun 26 18:28:50 resox bluetoothd[14098]: start_resume: resume failed
Jun 26 18:28:50 resox bluetoothd[14098]: Audio API: BT_ERROR -> BT_START_STREAM
Jun 26 18:28:50 resox bluetoothd[14098]: Unix client disconnected (fd=22)
Jun 26 18:28:50 resox bluetoothd[14098]: client_free(0xb9649ea8)

