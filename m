Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1115429201.9031.5.camel@pegasus>
References: <42792979.90109@xmission.com>
	 <20050507031314.548afb03.henryk@ploetzli.ch>
	 <1115429201.9031.5.camel@pegasus>
Content-Type: text/plain
Message-Id: <1115494053.9031.15.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 07 May 2005 21:27:33 +0200

Hi Henryk,

> > > Maybe for convenience, libsbc should compute the timeslice for the
> > > frame.
> > 
> > It does now. I added a function sbc_time(sbc_t *sbc) which computes the
> > microseconds for one frame. I then replaced the fixed value in a2play's
> > usleep() call with the time the whole packet should take to play (time
> > for one frame times number of frames in the packet) multiplied by
> > (arbitrarily chosen) 0.8 to make up for the time lost with computing and
> > sending.
> 
> the time that is eaten up by encoding or decoding could be measured with
> gettimeofday() and then you can subtract this from the whole time.
> 
> Since it is a linear operation we can make the SBC library do it all for
> us. Let sbc_encode() and sbc_decode() calculate the processing time and
> then store a sleep value for us inside sbc_t.

forget about this stupid idea. I tried it and it is not working out. So
I only moved the time calculation into sbc->duration and added the
gettimeofday() magic into a2play. This is somekind of working, but the
quality is not that good with the HP headphone.

I also figured out that the HP headphone has somekind of buffer and you
can send more than one AVDTP frame (equals 8 SBC frames). But it seems
that this is somekind of ringbuffer. Too many frames will overwrite
previous frames and make the sound a mess.

So the best thing is too encode two or three full AVDTP frames in
advance and have them ready to send. The sending can't be controlled be
usleep(). We need a time that kicks in every whatever msec and makes us
to transmit the next frame.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
