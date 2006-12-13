Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457F70F8.6040309@xmission.com>
Date: Tue, 12 Dec 2006 20:18:16 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] org.bluez.Audio and connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

Can we go back and look at audio connection init & inspect? I proposed
ListConnectedStreams and ways to examine each stream for profile and
status... we may start up an audio app after the connection was already
going so the app would have missed seeing the connect signals.

Do these look ok?

 	        array{string} ListAudioDevices()

                        Returns list of bdaddrs for devices that
                        report audio in their device class.

                array{string} Connect(string bdaddr)

                        Connects the headset/headphones using A2DP or
                        HSP/HFP or both. Returns the array of streams
                        representing the successful connections.

                void Disconnect(string bdaddr)

                        Disconnect all streams to the audio device.

                array{string} ListConnectedStreams()

                string StreamAddress(string stream)

                        Returns the bdaddr the indicated stream
                        connects to.

                boolean IsHeadset(string stream)

                        Return true if the stream represents a
                        headset.

                boolean IsSink(string stream)

                        Return true if the stream represents
                        headphones.

                boolean IsPlaying(string stream)

                        Return true if the stream is in a playing
                        state.

                boolean IsPaused(string stream)

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
