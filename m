Return-Path: <cyrus@holtmann.org>
From: Galaha Shine <galaha.a.s@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 13 Sep 2008 16:40:18 +0800
Message-Id: <1221295218.10961.9.camel@alex-laptop>
Mime-Version: 1.0
Subject: [Bluez-devel] bluetooth headset doesn't work well(Motorola HS820)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I have a blue-tooth headset connected to Ubuntu 8.04 but it does't work
well. I've created ~/.asoundrc as below:

pcm.bluetooth {
  type bluetooth
  device 20:04:07:80:BC:89
  profile voice
}

ctl.bluetooth {
        type bluetooth
}

now I can use command `aplay -Dbluetooth -v 2.wav` to play sound to the
headset, but the sound is little bit wired due to inaccurate rate. 

Playing WAVE '2.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Mono
Warning: rate is not accurate (requested = 16000Hz, got = 8000Hz)
         please, try the plug plugin (-Dplug:bluetooth)
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000

So I input command according to the aplay's recommendation `aplay
-Dplug:bluetooth -v 2.wav`. The problem comes out.

 aplay -Dplug:bluetooth -v 2.wav 
Playing WAVE '2.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Mono
Plug PCM: Rate conversion PCM (8000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 8000
  period_size  : 2000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2000
  period_event : 0
  start_threshold  : 8000
  stop_threshold   : 8000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Slave: Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000

It seems that ALSA plugs rate plugin. But I hear NOTHING from my headset
and aplay seems suspended. I turn on bluez debug flag and rebuild it. I
find the bluez suspending at 'bluetooth_playback_poll_descriptors'.


Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 930
bluetooth_hsp_write: count=0 frames_to_read=24 
Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 993
bluetooth_hsp_write: returning 24 
Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 912
bluetooth_hsp_write: areas->step=16 areas->first=0 offset=0, size=1000
io->nonblock=0 io->hw_ptr=0 io->appl_ptr=0 stream.fd=8 link_mtu=48
data->count=0  
Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 930
bluetooth_hsp_write: count=0 frames_to_read=24 
Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 993
bluetooth_hsp_write: returning 24 
Sep  7 23:18:59 alex-laptop aplay: DEBUG: pcm_bluetooth.c 802
bluetooth_playback_poll_descriptors: Space =2 pfd[0].fd=5 pfd[1].fd=6 
Sep  7 23:19:01 alex-laptop audio[7979]: Received AT+VGS=11

Now I go deep into ALSA then I find ALSA suspending at:
int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
{
        struct pollfd *pfd;
        unsigned short *revents;
        int i, npfds, pollio, err, err_poll;
        npfds = snd_pcm_poll_descriptors_count(pcm);
        if (npfds <= 0 || npfds >= 16) {
                SNDERR("Invalid poll_fds %d\n", npfds);
                return -EIO;
        }
        pfd = alloca(sizeof(*pfd) * npfds);
        revents = alloca(sizeof(*revents) * npfds);
        syslog( LOG_INFO, "%s", __FUNCTION__ ); 
        err = snd_pcm_poll_descriptors(pcm, pfd, npfds);
        if (err < 0)
                return err;
        if (err != npfds) {
                SNDMSG("invalid poll descriptors %d\n", err);
                return -EIO;
        }
        do {
                pollio = 0;
                err_poll = poll(pfd, npfds, timeout);    <-------------

It seems the bluez doesn't feed ALSA some signals. But why? I notice
'bluetooth_playback_start' haven't been invoked. Is it the point? Then I
keep tracing ALSA. I find in snd_pcm_rate_commit_area

                result = snd_pcm_mmap_commit(rate->gen.slave,
slave_offset,
slave_size);
                if (result < (snd_pcm_sframes_t)slave_size) {
                        if (result < 0)
                                return result;
                        result = snd_pcm_rewind(rate->gen.slave,
result);   <-----------
                        if (result < 0)
                                return result;
                        return 0;
                } 


The snd_pcm_mmap_commit returns with 24 which indicates bluetooth SCO
link mtu(48bytes). And it causes snd_pcm_rewind being called after every
package sent by bluetooth SCO link. Look at this piece of code in
snd_pcm_write_areas:
                if (state == SND_PCM_STATE_PREPARED) {
                        snd_pcm_sframes_t hw_avail = pcm->buffer_size -
avail;
                        hw_avail += frames;
                        /* some plugins might automatically start the
stream */
                        state = snd_pcm_state(pcm);

                        
                        if (state == SND_PCM_STATE_PREPARED &&
                            hw_avail >= (snd_pcm_sframes_t)
pcm->start_threshold) {
                                err = snd_pcm_start(pcm);
                                if (err < 0)
                                        goto _end;
                        }
                }

the 'avail' will be equal to pcm->buffer due to snd_pcm_rewind,
therefore the condition hw_avail>=pcm->start_threshold will not be
satisfied forever. That's why snd_pcm_start can't be called.



I don't know the mechanism of ALSA and I just assume ALSA wanna bluez
plugin sending whole period_size instead of only one 48bytes package. I
revise the bluez plugin:

#if 0 // this section is original bluez
        frame_size = areas->step / 8;
        if ((data->count + size * frame_size) <= data->link_mtu)
                frames_to_read = size;
        else
                frames_to_read = (data->link_mtu - data->count) /
frame_size;

        DBG("count=%d frames_to_read=%lu", data->count, frames_to_read);

        /* Ready for more data */
        buff = (uint8_t *) areas->addr +
                        (areas->first + areas->step * offset) / 8;
        memcpy(data->buffer + data->count, buff, frame_size *
frames_to_read);

        /* Remember we have some frames in the pipe now */
        data->count += frames_to_read * frame_size;
        if (data->count != data->link_mtu) {
                ret = frames_to_read;
                goto done;
        }

        rsend = send(data->stream.fd, data->buffer, data->link_mtu,
                        io->nonblock ? MSG_DONTWAIT : 0);
        if (rsend > 0) {
                /* Reset count pointer */
                data->count = 0;

                ret = frames_to_read;
        } else if (rsend < 0)
                ret = (errno == EPIPE) ? -EIO : -errno;
        else
                ret = -EIO;
#else           
        frame_size = areas->step / 8;

        buff = (uint8_t *) areas->addr +
                        (areas->first + areas->step * offset) / 8;

        tobesent = frame_size*size;
        
        while( rsend<tobesent )
        {
                if( tobesent-rsend>data->link_mtu )
                sent = send(data->stream.fd, buff
+counter*data->link_mtu,
data->link_mtu,
                                io->nonblock ? MSG_DONTWAIT :
0);               
                else
                sent = send(data->stream.fd, buff
+counter*data->link_mtu,
tobesent-rsend,
                                io->nonblock ? MSG_DONTWAIT :
0);               

                if( sent > 0 )
                {
                        if( sent != data->link_mtu && tobesent-rsend >
data->link_mtu )
                                DBG("got problem!");
                        counter++;
                        rsend+=sent;
                }
                else if (rsend < 0)
                {
                        ret = (errno == EPIPE) ? -EIO : -errno;
                        break;
                }
                else
                {
                        ret = -EIO;
                        break;
                }
        }
        ret = size;
#endif  



After this revision, the headset works but the performance isn't as good
as playing MONO 8000Hz wav directly to headset with 'aplay -Dbluetooth
1.wav'. Any hints would be appreciated.

Regards,
Galaha



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
