Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Oct 2008 20:26:49 +0200
From: Andre Roth <lynx@netlabs.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20081014202649.47e57db0@netlabs.org>
Mime-Version: 1.0
Subject: [Bluez-devel] BT_GETCAPABILITIES failed
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hello, =


I'm trying to get my headset working, a HBH-610a from sony-ericsson.
It worked with the old hci_usb and the flow-control patches until kernel
2.6.21.5

My setup:
- kernel 2.6.27 or vmlinuz-2.6.26-mh7
- bluez-utils 4.13
- bluez-gnome-1.8
- bluez-firmware-1.2 (unsure if needed)

I'm starting bluetoothd and I'm able to pair the headset using the
bluetooth-wizard. The pairing sometimes crashes the kernel with
2.6.26-mh7. =


My .asoundrc:
pcm.headset {
   type bluetooth
   device 00:12:EE:A6:FC:1E
}

But when I'm trying to record audio from the headset I get the
following, independent of prior pairing or not:

$ arecord -D headset -f S16_LE test.wav
ALSA lib pcm_bluetooth.c:1516:(audioservice_recv) trying to receive msg fro=
m audio service...
ALSA lib pcm_bluetooth.c:1520:(audioservice_recv) Received BT_GETCAPABILITI=
ES_RSP
ALSA lib pcm_bluetooth.c:1624:(bluetooth_init) BT_GETCAPABILITIES failed : =
Input/output error(5)
arecord: main:564: audio open error: Input/output error

I tracked it down to the function manager_find_device in
audio/manager.c, called from handle_getcapabilities_req in
audio/unix.c:

    struct audio_device *manager_find_device(const bdaddr_t *bda,
                                             const char *interface,
                                             gboolean connected)
    {
        GSList *l;
        for (l =3D devices; l !=3D NULL; l =3D l->next) {
 =

since devices is NULL, the function fails. no pairing or connection
attempt. the functions audio_manager_init and manager_get_device are
never called, which would probably fill up the linked list.

Here my questions:
- what am I doing wrong ?
- is the procedure right for arecord/aplay ?
- what can I do to help ?

regards

 andr=E9

--
Andre Roth   | <lynx@netlabs.org>
GPG: FADF988E| 0959 4D7C F8ED DF4B 90A6  CF71 9EDF 52D1 FADF 988E

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
