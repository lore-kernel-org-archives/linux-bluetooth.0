Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 21:15:52 +1000 (EST)
From: Michael McCallum <linuxbluez@mccallum.nu>
To: linux-bluetooth@vger.kernel.org
Subject: AVRCP Passthrough Commands issue with Kenwood Car stereo
Message-ID: <df6cc686-a338-45d8-ae76-a9245036451f@mail1>
In-Reply-To: <636c01cf-20fb-428a-9b68-65951d99b94f@mail1>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

My apologies if this isn't the correct list for this post - I couldn't find a bluetooth "users" list.

I have an Samsung Galaxy SII mobile phone running the latest Cyanogenmod Android build. The phone has an issue where the Bluetooth audio stream doesn't stream properly after the phone is paired to my Subaru (Kenwood) car stereo.

Once the phone is paired - the music will attempt to start playing - but appears to get stuck in a play/pause loop - when the stereo will play about a 1/10 of a second of sound, then pause for a second, and then play another spurt of music etc. The car stereo status icon flicks between play & pause whilst this is occurring (although the music player on the phone just shows the track as playing). I have a debug log of the events below.  The Kenwood used to work properly with the older Android builds of CM7 - my understanding is that the latest release now uses AVRCP V1.3 which may have broken something?

Whilst I'm not a developer - the issue I'm having appears to be related to issues in this post?? : http://www.spinics.net/lists/linux-bluetooth/msg22010.html

In the interests of brevity, if anyone is able to assist I have posted a more substantial information of the issue here : http://forum.xda-developers.com/showpost.php?p=24790310&postcount=24310 - along with further logs.

Thanks in advance for your time & assistance
Cheers, Mike

#############################################################################################


--------- beginning of /dev/log/system
Window already focused, ignoring focus gain of: com.android.internal.view.IInputMethodClient$Stub$Proxy@4175e3a8
--------- beginning of /dev/log/main
Device property changed: 00:06:F7:EB:90:6F property: Connected value: true
Headset=false; Bluetooth=false
Accepting HF connection.
Successful accept() on AG socket 84: new socket 89, address 00:06:F7:EB:90:6F, RFCOMM channel 10
connect notification!
Incoming connection from handsfree 00:06:F7:EB:90:6F on channel 10
Incoming rfcomm (handsfree) connection from 00:06:F7:EB:90:6Fon channel 10
Entering IncomingHandsfree state with: 2
handleIncomingConnection:2:true
Device: 00:06:F7:EB:90:6F Headset state0 -> 1
CONNECTION_STATE_CHANGE: 00:06:F7:EB:90:6F: 0 -> 1
onProfileStateChanged: profile HEADSET newProfileState 1
initializeNativeDataNative: ALREADY CONNECTED!
Rfcomm connected
Device: 00:06:F7:EB:90:6F Headset state1 -> 2
Saved priority 00:06:F7:EB:90:6F = 1000
CONNECTION_STATE_CHANGE: 00:06:F7:EB:90:6F: 1 -> 2
setDeviceConnectionState() device: 20, state 1, address 00:06:F7:EB:90:6F
getDeviceForStrategy() strategy 4, device 2
getDeviceForStrategy() strategy 1, device 1
getDeviceForStrategy() strategy 2, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 3, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 1, device 1
getDeviceForStrategy() strategy 2, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 3, device 2
getDeviceForStrategy() strategy 4, device 2
AudioPolicyManager::getDeviceForInputSourceNotification input:0x100000 mPhoneState:0
AudioHardware::setParameters(keyValuePairs="routing=1048576")
### setDeivceInCall devices 1048576, force = 1
AudioHardware::setDevices(devices=00100000h, mask=C3FC0000h)
### setDeivceInCall = 00100000h mEnabledDualMic 1
AudioHardware::setParameters(keyValuePairs="bt_headset_name=CAR PHONE;bt_headset_nrec=on")
setBluetoothNrEcOff(false)
Entering ACL Connected state with: 102
onProfileStateChanged: profile HEADSET newProfileState 2
GC_CONCURRENT freed 1089K, 13% free 13747K/15687K, paused 3ms+12ms
AudioHardware::setParameters(keyValuePairs="bt_headset_nrec=off")
setBluetoothNrEcOff(true)
A2DP: onSinkPropertyChanged newState is: 1mPlayingA2dpDevice: null
A2DP state : device: 00:06:F7:EB:90:6F State:0->1
agent_event_filter: Received method org.bluez.Agent:Authorize
First check pass for incoming A2DP / AVRCP connection from 00:06:F7:EB:90:6F
Entering IncomingA2dp state with: 4
handleIncomingConnection:4:true
allowIncomingConnect: A2DP: 00:06:F7:EB:90:6F:true
onAgentAuthorize(/org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F, 0000110d-0000-1000-8000-00805f9b34fb) = true
onProfileStateChanged: profile A2DP newProfileState 1
No input device configuration file found for device 'AVRCP'.
New device: id=10, fd=193, path='/dev/input/event9', name='AVRCP', classes=0x80000001, configuration='', keyLayout='/system/usr/keylayout/AVRCP.kl', keyCharacterMap='/system/usr/keychars/Generic.kcm', builtinKeyboard=false
Device added: id=10, name='AVRCP', sources=0x00000101
onGetPlayStatusRequest
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: null
setDeviceConnectionState() device: 80, state 1, address 00:06:F7:EB:90:6F
a2dp_init rate: 44100 channels: 2
A2DP state : device: 00:06:F7:EB:90:6F State:1->2
sendMetaData /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F
a2dp_thread started
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 0
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 1
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 2
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 3
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 4
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 5
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 6
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 7
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 8
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 9
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 10
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 11
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 12
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 13
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 14
isSeparatedStream: false
bluetooth_init
Meta data info is trackname: Unknown artist: Unknown
mMediaNumber: 0 mediaCount 0
mPostion 0 album: Unknownduration 0
AudioFlinger's thread 0x160be70 ready to run
AudioFlinger's thread 0x16019f0 ready to run
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 0
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 1
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 2
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 3
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 4
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 5
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 6
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 7
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 8
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 9
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 10
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 11
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 12
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 13
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 14
isSeparatedStream: false
getDeviceForStrategy() strategy 4, device 2
getDeviceForStrategy() strategy 1, device 80
a2dp_stop
getDeviceForStrategy() strategy 2, device 82
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 3, device 80
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 1, device 80
getDeviceForStrategy() strategy 2, device 82
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 3, device 80
getDeviceForStrategy() strategy 4, device 2
AudioHardware::setParameters(keyValuePairs="A2dpSuspended=false")
Entering ACL Connected state with: 102
sendEvent /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F data 0
onProfileStateChanged: profile A2DP newProfileState 2
GC_CONCURRENT freed 404K, 16% free 9488K/11207K, paused 2ms+3ms
Removing device '/dev/input/event9' due to inotify event
Removed device: path=/dev/input/event9 name=AVRCP id=10 fd=193 classes=0x80000001
Device removed: id=10, name='AVRCP', sources=0x00000101
A2DP: onSinkPropertyChanged newState is: 0mPlayingA2dpDevice: null
setDeviceConnectionState() device: 80, state 0, address 00:06:F7:EB:90:6F
setStreamMute() stream 1, mute 1, output 1, mMuteCount 0
setStreamMute() stream 3, mute 1, output 1, mMuteCount 0
setStreamMute() stream 9, mute 1, output 1, mMuteCount 0
setStreamMute() stream 10, mute 1, output 1, mMuteCount 0
setStreamMute() stream 12, mute 1, output 1, mMuteCount 0
setStreamMute() stream 13, mute 1, output 1, mMuteCount 0
setStreamMute() stream 14, mute 1, output 1, mMuteCount 0
setStreamMute() stream 1, mute 0, output 1, mMuteCount 1
setStreamMute() stream 3, mute 0, output 1, mMuteCount 1
setStreamMute() stream 9, mute 0, output 1, mMuteCount 1
setStreamMute() stream 10, mute 0, output 1, mMuteCount 1
setStreamMute() stream 12, mute 0, output 1, mMuteCount 1
setStreamMute() stream 13, mute 0, output 1, mMuteCount 1
setStreamMute() stream 14, mute 0, output 1, mMuteCount 1
getDeviceForStrategy() strategy 4, device 2
getDeviceForStrategy() strategy 1, device 1
getDeviceForStrategy() strategy 2, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 3, device 2
A2DP state : device: 00:06:F7:EB:90:6F State:2->0
a2dp_cleanup
bluetooth_close
a2dp_thread finished
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 1, device 1
getDeviceForStrategy() strategy 2, device 2
getDeviceForStrategy() strategy 0, device 2
getDeviceForStrategy() strategy 3, device 2
getDeviceForStrategy() strategy 4, device 2
Entering IncomingA2dp state with: 53
Entering ACL Connected state with: 102
onProfileStateChanged: profile A2DP newProfileState 0
Start proc com.android.music for broadcast com.android.music/.MediaButtonIntentReceiver: pid=3613 uid=10025 gids={3003, 1015}
Turning on JNI app bug workarounds for target SDK version 9...
Headset=false; Bluetooth=false
Remote Control registerMediaButtonIntent() for PendingIntent{417953c0: PendingIntentRecord{416998c8 com.android.music broadcastIntent}}
Attempting to allocate OMX node 'OMX.google.mp3.decoder'
Successfully allocated OMX node 'OMX.google.mp3.decoder'
New audio session: 7
restored queue, currently at position 18912/110420 (requested 18912)
GC_CONCURRENT freed 331K, 5% free 9218K/9671K, paused 1ms+5ms
Meta data info is trackname: On The Road Again artist: FourPlay
mMediaNumber: 8079 mediaCount 0
mPostion 0 album: TheJoyOfduration 0
failed to extract an album art
failed to extract an album art
GC_FOR_ALLOC freed 105K, 5% free 9196K/9671K, paused 21ms
Grow heap (frag case) to 9.447MB for 367252-byte allocation
GC_FOR_ALLOC freed <1K, 5% free 9554K/10055K, paused 13ms
GC_FOR_ALLOC freed <1K, 5% free 9553K/10055K, paused 13ms
Grow heap (frag case) to 9.696MB for 262160-byte allocation
GC_FOR_ALLOC freed <1K, 6% free 9809K/10375K, paused 11ms
Selected configuration: speaker
Invalid argument error in setParameter(1000, (short) 10000) == -4
A2DP: onSinkPropertyChanged newState is: 1mPlayingA2dpDevice: null
A2DP state : device: 00:06:F7:EB:90:6F State:0->1
agent_event_filter: Received method org.bluez.Agent:Authorize
First check pass for incoming A2DP / AVRCP connection from 00:06:F7:EB:90:6F
Entering IncomingA2dp state with: 4
handleIncomingConnection:4:true
onProfileStateChanged: profile A2DP newProfileState 1
allowIncomingConnect: A2DP: 00:06:F7:EB:90:6F:true
onAgentAuthorize(/org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F, 0000110d-0000-1000-8000-00805f9b34fb) = true
No input device configuration file found for device 'AVRCP'.
New device: id=11, fd=193, path='/dev/input/event9', name='AVRCP', classes=0x80000001, configuration='', keyLayout='/system/usr/keylayout/AVRCP.kl', keyCharacterMap='/system/usr/keychars/Generic.kcm', builtinKeyboard=false
Device added: id=11, name='AVRCP', sources=0x00000101
onGetPlayStatusRequest
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: null
setDeviceConnectionState() device: 80, state 1, address 00:06:F7:EB:90:6F
a2dp_init rate: 44100 channels: 2
A2DP state : device: 00:06:F7:EB:90:6F State:1->2
sendMetaData /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F
Meta data info is trackname: On The Road Again artist: FourPlay
a2dp_thread started
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 0
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 1
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 2
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 3
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 4
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 5
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 6
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 7
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 8
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 9
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 10
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 11
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 12
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 13
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 14
isSeparatedStream: false
bluetooth_init
mMediaNumber: 8079 mediaCount 0
mPostion 0 album: TheJoyOfduration 0
AudioFlinger's thread 0x1615040 ready to run
AudioFlinger's thread 0x1614e98 ready to run
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 0
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 1
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 2
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 3
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 4
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 5
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 6
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 7
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 8
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 9
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 10
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 11
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 12
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 13
isSeparatedStream: false
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 14
isSeparatedStream: false
getDeviceForStrategy() strategy 4, device 2
getDeviceForStrategy() strategy 1, device 80
a2dp_stop
getDeviceForStrategy() strategy 2, device 82
getDeviceForStrategy() strategy 0, device 80
moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
moveEffectChain_l() effect chain for session 7 not on source thread 0x15ff100
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 3, device 80
sendEvent /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F data 0
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 1, device 80
getDeviceForStrategy() strategy 2, device 82
getDeviceForStrategy() strategy 0, device 80
getDeviceForStrategy() strategy 3, device 80
getDeviceForStrategy() strategy 4, device 2
AudioHardware::setParameters(keyValuePairs="A2dpSuspended=false")
Entering ACL Connected state with: 102
onProfileStateChanged: profile A2DP newProfileState 2
GC_CONCURRENT freed 389K, 16% free 9521K/11207K, paused 2ms+2ms
AudioFocus requestAudioFocus() from android.media.AudioManager@4132b3d0com.android.music.MediaPlaybackService$3@4132a2b8
Remote Control registerMediaButtonIntent() for PendingIntent{41687a90: PendingIntentRecord{416998c8 com.android.music broadcastIntent}}
startOutput() output 12, stream 3, session 7
android::AudioSystem::isSeparatedStream(audio_stream_type_t) called!
audio_stream_type_t: 3
isSeparatedStream: false
getDeviceForStrategy() strategy 0, device 80
failed to extract an album art
failed to extract an album art
bluetooth_configure
Received BT_RESPONSE - BT_GET_CAPABILITIES
Received BT_RESPONSE - BT_OPEN
bluetooth_a2dp_hw_params sending configuration:
channel_mode: JOINT STEREO
frequency: 44100
allocation_method: LOUDNESS
subbands: 8
block_length: 16
min_bitpool: 2
max_bitpool: 53
Received BT_RESPONSE - BT_SET_CONFIGURATION
MTU: 895
frame_duration: 2902 us
allocation=0
subbands=1
blocks=3
bitpool=53
bluetooth_start
GC_FOR_ALLOC freed 389K, 10% free 9440K/10375K, paused 32ms
PlayState changed 1
sendEvent /org/bluez/2100/hci0/dev_00_06_F7_EB_90_6F data 1
GC_CONCURRENT freed 4K, 6% free 9828K/10375K, paused 1ms+6ms
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00006e00, server=00004600
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
write blocked for 1079 msecs, 1 delayed writes, thread 0x1614e98
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
bluetooth_start
_out_buf_thread_func: a2dp_write failed (-110)
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=0000dc00, server=0000b400
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00014a00, server=00012200
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
write blocked for 943 msecs, 6 delayed writes, thread 0x1614e98
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=0001b800, server=00019000
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00022600, server=0001fe00
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
GC_CONCURRENT freed 372K, 15% free 9537K/11207K, paused 2ms+3ms
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00029400, server=00026c00
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
write blocked for 1136 msecs, 11 delayed writes, thread 0x1614e98
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00030200, server=0002da00
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00037000, server=00034800
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
write blocked for 941 msecs, 16 delayed writes, thread 0x1614e98
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=0003de00, server=0003b600
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00044c00, server=00042400
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=0004ba00, server=00049200
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
write blocked for 1121 msecs, 21 delayed writes, thread 0x1614e98
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
GC_CONCURRENT freed 754K, 11% free 14056K/15687K, paused 10ms+5ms
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00052800, server=00050000
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
a2dp_stop
bluetooth_stop
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00059600, server=00056e00
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
a2dp_stop
bluetooth_stop
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
GC_CONCURRENT freed 347K, 15% free 9577K/11207K, paused 2ms+4ms
write blocked for 941 msecs, 26 delayed writes, thread 0x1614e98
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
obtainBuffer timed out (is the CPU pegged?) 0x1626980 user=00060400, server=0005dc00
Received BT_RESPONSE - BT_START_STREAM
Received BT_RESPONSE - BT_NEW_STREAM
A2DP: onSinkPropertyChanged newState is: 10mPlayingA2dpDevice: null
a2dp_stop
bluetooth_stop
A2DP Playing state : device: 00:06:F7:EB:90:6F State:11->10
Received BT_RESPONSE - BT_STOP_STREAM
A2DP: onSinkPropertyChanged newState is: 2mPlayingA2dpDevice: 00:06:F7:EB:90:6F
A2DP Playing state : device: 00:06:F7:EB:90:6F State:10->11
_out_buf_thread_func: a2dp_write failed (-110)
bluetooth_start
