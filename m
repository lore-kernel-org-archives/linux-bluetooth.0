Return-Path: <cyrus@holtmann.org>
Message-ID: <477F94BC.3040509@gmail.com>
Date: Sun, 06 Jan 2008 00:31:24 +1000
From: 1 <it.had.even@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Possible insignificant bug in pcm_bluetooth.c
	(bluez-utils)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,
 here is question  raised while digging thru bluez-utils source.
Piece from /audio/pcm_bluetooth.c (function bluetooth_parse_config) :

if (strcmp(id, "mode") == 0) {
    if (snd_config_get_string(n, &mode) < 0) {
        SNDERR("Invalid type for %s", id);
        return -EINVAL;
    }

    if (strcmp(pref, "auto") == 0) {
        bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_AUTO;
        bt_config->has_channel_mode = 1;
    } else if (strcmp(pref, "mono") == 0) {
        bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_MONO;
        bt_config->has_channel_mode = 1;
    } else if (strcmp(pref, "dual") == 0) {
        bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL;
        bt_config->has_channel_mode = 1;
    } else if (strcmp(pref, "stereo") == 0) {
        bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_STEREO;
        bt_config->has_channel_mode = 1;
    } else if (strcmp(pref, "joint") == 0) {
        bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
        bt_config->has_channel_mode = 1;
    }
    continue;
}

if (strcmp(id, "allocation") == 0) {
    if (snd_config_get_string(n, &allocation) < 0) {
        SNDERR("Invalid type for %s", id);
        return -EINVAL;
    }

    if (strcmp(pref, "auto") == 0) {
        bt_config->allocation_method = BT_A2DP_ALLOCATION_AUTO;
        bt_config->has_allocation_method = 1;
    } else if (strcmp(pref, "loudness") == 0) {
        bt_config->allocation_method = BT_A2DP_ALLOCATION_LOUDNESS;
        bt_config->has_allocation_method = 1;
    } else if (strcmp(pref, "snr") == 0) {
        bt_config->allocation_method = BT_A2DP_ALLOCATION_SNR;
        bt_config->has_allocation_method = 1;
    }
    continue;
}

As I understood, bt_config->channel_mode and 
bt_config->allocation_method will never be set properly, because of
wrong variable in strcmp : strcmp(pref,"auto").
If I am right, there must be strcmp(mode,"auto") and 
strcmp(allocation,"auto") respectively.

Further, if it is bug, it is insignificant for now the configuration of 
A2DP (~/.asoundrc) is not fully implemented.
Found this in above file:
    /* FIXME: this needs to be really implemented (take into account 
real asoundrc settings + ALSA hw settings ) once server side sends us
    more than one possible configuration */

And something else: I got choppy sound (it chops every 2 sec) when 
listening my A2DP stereo headset Southwing SA505 (BT dongle ASUS WL-BTD-202,
Ubuntu Gutsy, bluez-3.24). Tried to:
- change configuration in ~/.asoundrc but unfortunately settings for 
A2DP unimplemented .
- changed hcid.conf -> lm accept,master and removed lp rswitch. with no use
Anybody knows what can it be?

Now waiting for new release in hope that A2DP settings will be 
implemented :)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
