Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <636c01cf-20fb-428a-9b68-65951d99b94f@mail1>
References: <CAJdJm_PE-_3OZoDCXRf6wne_myQDCSV9wcvA9RnGt_W6uH5BRQ@mail.gmail.com>
 <636c01cf-20fb-428a-9b68-65951d99b94f@mail1>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 13 Apr 2012 14:37:12 -0300
Message-ID: <CAMOw1v65seDFRnrJ37QmmHK65j3gFyug95tL_j9Bw2BC0eZmbg@mail.gmail.com>
Subject: Re: AVRCP Passthrough Commands issue with Kenwood Car stereo
To: Michael McCallum <michael@mccallum.nu>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 13, 2012 at 8:14 AM, Michael McCallum <michael@mccallum.nu> wrote:
> Hi All,
>
> My apologies if this isn't the correct list for this post - I couldn't find a bluetooth "users" list.
>
> I have an Samsung Galaxy SII mobile phone running the latest Cyanogenmod Android build. The phone has an issue where the Bluetooth audio stream doesn't stream properly after the phone is paired to my Subaru (Kenwood) car stereo.
>
> Once the phone is paired - the music will attempt to start playing - but appears to get stuck in a play/pause loop - when the stereo will play about a 1/10 of a second of sound, then pause for a second, and then play another spurt of music etc. The car stereo status icon flicks between play & pause whilst this is occurring (although the music player on the phone just shows the track as playing). I have a debug log of the events below.  The Kenwood used to work properly with the older Android builds of CM7 - my understanding is that the latest release now uses AVRCP V1.3 which may have broken something?

As far as I know Cyanogen uses another implementation of AVRCP, not
the one upstream.

>
> Whilst I'm not a developer - the issue I'm having appears to be related to issues in this post?? : http://www.spinics.net/lists/linux-bluetooth/msg22010.html
>
> In the interests of brevity, if anyone is able to assist I have posted a more substantial information of the issue here : http://forum.xda-developers.com/showpost.php?p=24790310&postcount=24310 - along with further logs.

Could you point out where is the source code for their version of BlueZ?

Lucas De Marchi
>
> Thanks in advance for your time & assistance
> Cheers, Mike
>
> #############################################################################################
>
>
> --------- beginning of /dev/log/system
> Window already focused, ignoring focus gain of: com.android.internal.view.IInputMethodClient$Stub$Proxy@4175e3a8
> --------- beginning of /dev/log/main
> Device property changed: 00:06:F7:EB:90:6F property: Connected value: true
> Headset=false; Bluetooth=false
> Accepting HF connection.
> Successful accept() on AG socket 84: new socket 89, address 00:06:F7:EB:90:6F, RFCOMM channel 10
> connect notification!
> Incoming connection from handsfree 00:06:F7:EB:90:6F on channel 10
> Incoming rfcomm (handsfree) connection from 00:06:F7:EB:90:6Fon channel 10
> Entering IncomingHandsfree state with: 2
> handleIncomingConnection:2:true
> Device: 00:06:F7:EB:90:6F Headset state0 -> 1
> CONNECTION_STATE_CHANGE: 00:06:F7:EB:90:6F: 0 -> 1
> onProfileStateChanged: profile HEADSET newProfileState 1
> initializeNativeDataNative: ALREADY CONNECTED!
> Rfcomm connected
> Device: 00:06:F7:EB:90:6F Headset state1 -> 2
> Saved priority 00:06:F7:EB:90:6F = 1000
> CONNECTION_STATE_CHANGE: 00:06:F7:EB:90:6F: 1 -> 2
> setDeviceConnectionState() device: 20, state 1, address 00:06:F7:EB:90:6F
> getDeviceForStrategy() strategy 4, device 2
> getDeviceForStrategy() strategy 1, device 1
> getDeviceForStrategy() strategy 2, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 3, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 1, device 1
> getDeviceForStrategy() strategy 2, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 3, device 2
> getDeviceForStrategy() strategy 4, device 2
> AudioPolicyManager::getDeviceForInputSourceNotification input:0x100000 mPhoneState:0
> AudioHardware::setParameters(keyValuePairs="routing=1048576")
> ### setDeivceInCall devices 1048576, force = 1
> AudioHardware::setDevices(devices=00100000h, mask=C3FC0000h)
> ### setDeivceInCall = 00100000h mEnabledDualMic 1
> AudioHardware::setParameters(keyValuePairs="bt_headset_name=CAR PHONE;bt_headset_nrec=on")
> setBluetoothNrEcOff(false)
> Entering ACL Connected state with: 102
> onProfileStateChanged: profile HEADSET newProfileState 2
> GC_CONCURRENT freed 1089K, 13% free 13747K/15687K, paused 3ms+12ms
> AudioHardware::setParameters(keyValuePairs="bt_headset_nrec=off")
> setBluetoothNrEcOff(true)
> A2DP: onSinkPropertyChanged newState is: 1mPlayingA2dpDevice: null
> A2DP state : device: 00:06:F7:EB:90:6F State:0->1
> agent_event_filter: Received method org.bluez.Agent:Authorize
> First check pass for incoming A2DP / AVRCP connection from 00:06:F7:EB:90:6F
> Entering IncomingA2dp state with: 4
> handleIncomingConnection:4:true
> allowIncomingConnect: A2DP: 00:06:F7:EB:90:6F:true
> onAgentAuthorize(/org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F, 0000110d-0000-1000-8000-00805f9b34fb) = true
> onProfileStateChanged: profile A2DP newProfileState 1
> No input device configuration file found for device 'AVRCP'.
> New device: id=10, fd=193, path='/dev/input/event9', name='AVRCP', classes=0x80000001, configuration='', keyLayout='/system/usr/keylayout/AVRCP.kl', keyCharacterMap='/system/usr/keychars/Generic.kcm', builtinKeyboard=false
> Device added: id=10, name='AVRCP', sources=0x00000101
> onGetPlayStatusRequest
> A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: null
> setDeviceConnectionState() device: 80, state 1, address 00:06:F7:EB:90:6F
> a2dp_init rate: 44100 channels: 2
> A2DP state : device: 00:06:F7:EB:90:6F State:1->2
> sendMetaData /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F
> a2dp_thread started
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 0
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 1
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 2
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 3
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 4
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 5
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 6
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 7
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 8
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 9
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 10
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 11
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 12
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 13
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 14
> isSeparatedStream: false
> bluetooth_init
> Meta data info is trackname: Unknown artist: Unknown
> mMediaNumber: 0 mediaCount 0
> mPostion 0 album: Unknownduration 0
> AudioFlinger's thread 0x160be70 ready to run
> AudioFlinger's thread 0x16019f0 ready to run
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 0
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 1
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 2
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 3
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 4
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 5
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 6
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 7
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 8
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 9
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 10
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 11
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 12
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 13
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 14
> isSeparatedStream: false
> getDeviceForStrategy() strategy 4, device 2
> getDeviceForStrategy() strategy 1, device 80
> a2dp_stop
> getDeviceForStrategy() strategy 2, device 82
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 3, device 80
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 1, device 80
> getDeviceForStrategy() strategy 2, device 82
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 3, device 80
> getDeviceForStrategy() strategy 4, device 2
> AudioHardware::setParameters(keyValuePairs="A2dpSuspended=false")
> Entering ACL Connected state with: 102
> sendEvent /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F data 0
> onProfileStateChanged: profile A2DP newProfileState 2
> GC_CONCURRENT freed 404K, 16% free 9488K/11207K, paused 2ms+3ms
> Removing device '/dev/input/event9' due to inotify event
> Removed device: path=/dev/input/event9 name=AVRCP id=10 fd=193 classes=0x80000001
> Device removed: id=10, name='AVRCP', sources=0x00000101
> A2DP: onSinkPropertyChanged newState is: 0mPlayingA2dpDevice: null
> setDeviceConnectionState() device: 80, state 0, address 00:06:F7:EB:90:6F
> setStreamMute() stream 1, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 3, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 9, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 10, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 12, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 13, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 14, mute 1, output 1, mMuteCount 0
> setStreamMute() stream 1, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 3, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 9, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 10, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 12, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 13, mute 0, output 1, mMuteCount 1
> setStreamMute() stream 14, mute 0, output 1, mMuteCount 1
> getDeviceForStrategy() strategy 4, device 2
> getDeviceForStrategy() strategy 1, device 1
> getDeviceForStrategy() strategy 2, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 3, device 2
> A2DP state : device: 00:06:F7:EB:90:6F State:2->0
> a2dp_cleanup
> bluetooth_close
> a2dp_thread finished
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 1, device 1
> getDeviceForStrategy() strategy 2, device 2
> getDeviceForStrategy() strategy 0, device 2
> getDeviceForStrategy() strategy 3, device 2
> getDeviceForStrategy() strategy 4, device 2
> Entering IncomingA2dp state with: 53
> Entering ACL Connected state with: 102
> onProfileStateChanged: profile A2DP newProfileState 0
> Start proc com.android.music for broadcast com.android.music/.MediaButtonIntentReceiver: pid=3613 uid=10025 gids={3003, 1015}
> Turning on JNI app bug workarounds for target SDK version 9...
> Headset=false; Bluetooth=false
> Remote Control registerMediaButtonIntent() for PendingIntent{417953c0: PendingIntentRecord{416998c8 com.android.music broadcastIntent}}
> Attempting to allocate OMX node 'OMX.google.mp3.decoder'
> Successfully allocated OMX node 'OMX.google.mp3.decoder'
> New audio session: 7
> restored queue, currently at position 18912/110420 (requested 18912)
> GC_CONCURRENT freed 331K, 5% free 9218K/9671K, paused 1ms+5ms
> Meta data info is trackname: On The Road Again artist: FourPlay
> mMediaNumber: 8079 mediaCount 0
> mPostion 0 album: TheJoyOfduration 0
> failed to extract an album art
> failed to extract an album art
> GC_FOR_ALLOC freed 105K, 5% free 9196K/9671K, paused 21ms
> Grow heap (frag case) to 9.447MB for 367252-byte allocation
> GC_FOR_ALLOC freed <1K, 5% free 9554K/10055K, paused 13ms
> GC_FOR_ALLOC freed <1K, 5% free 9553K/10055K, paused 13ms
> Grow heap (frag case) to 9.696MB for 262160-byte allocation
> GC_FOR_ALLOC freed <1K, 6% free 9809K/10375K, paused 11ms
> Selected configuration: speaker
> Invalid argument error in setParameter(1000, (short) 10000) == -4
> A2DP: onSinkPropertyChanged newState is: 1mPlayingA2dpDevice: null
> A2DP state : device: 00:06:F7:EB:90:6F State:0->1
> agent_event_filter: Received method org.bluez.Agent:Authorize
> First check pass for incoming A2DP / AVRCP connection from 00:06:F7:EB:90:6F
> Entering IncomingA2dp state with: 4
> handleIncomingConnection:4:true
> onProfileStateChanged: profile A2DP newProfileState 1
> allowIncomingConnect: A2DP: 00:06:F7:EB:90:6F:true
> onAgentAuthorize(/org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F, 0000110d-0000-1000-8000-00805f9b34fb) = true
> No input device configuration file found for device 'AVRCP'.
> New device: id=11, fd=193, path='/dev/input/event9', name='AVRCP', classes=0x80000001, configuration='', keyLayout='/system/usr/keylayout/AVRCP.kl', keyCharacterMap='/system/usr/keychars/Generic.kcm', builtinKeyboard=false
> Device added: id=11, name='AVRCP', sources=0x00000101
> onGetPlayStatusRequest
> A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: null
> setDeviceConnectionState() device: 80, state 1, address 00:06:F7:EB:90:6F
> a2dp_init rate: 44100 channels: 2
> A2DP state : device: 00:06:F7:EB:90:6F State:1->2
> sendMetaData /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F
> Meta data info is trackname: On The Road Again artist: FourPlay
> a2dp_thread started
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 0
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 1
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 2
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 3
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 4
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 5
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 6
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 7
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 8
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 9
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 10
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 11
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 12
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 13
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 14
> isSeparatedStream: false
> bluetooth_init
> mMediaNumber: 8079 mediaCount 0
> mPostion 0 album: TheJoyOfduration 0
> AudioFlinger's thread 0x1615040 ready to run
> AudioFlinger's thread 0x1614e98 ready to run
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 0
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 1
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 2
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 3
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 4
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 5
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 6
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 7
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 8
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 9
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 10
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 11
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 12
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 13
> isSeparatedStream: false
> android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
> audio_stream_type_t: 14
> isSeparatedStream: false
> getDeviceForStrategy() strategy 4, device 2
> getDeviceForStrategy() strategy 1, device 80
> a2dp_stop
> getDeviceForStrategy() strategy 2, device 82
> getDeviceForStrategy() strategy 0, device 80
> moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
> moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
> moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 3, device 80
> sendEvent /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F data 0
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 1, device 80
> getDeviceForStrategy() strategy 2, device 82
> getDeviceForStrategy() strategy 0, device 80
> getDeviceForStrategy() strategy 3, device 80
> getDeviceForStrategy() strategy 4, device 2
> AudioHardware::setParameters(keyValuePairs="A2dpSuspended=false")
> Entering ACL Connected state with: 102
> onProfileStateChanged: profile A2DP newProfileState 2
> GC_CONCURRENT freed 389K, 16% free 9521K/11207K, paused 2ms+2ms
> AudioFocus requestAudioFocus() from android.media.AudioManager@4132b3d0com.android.music.MediaPlaybackService$3@4132a2b8
> Remote Control registerMediaButtonIntent() for PendingIntent{41687a90: PendingIntentRecord{416998c8 com.android.music broadcastIntent}}


The issued you are facing can also be an issue with these pending
intents. I don't know for sure since I don't have access to this
source code.

Lucas De Marchi
