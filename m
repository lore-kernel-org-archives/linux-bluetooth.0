Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 05:18:55 +0100
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: linux-bluetooth@vger.kernel.org
Subject: Failed to connect: org.bluez.Error.Failed
Message-Id: <20160126051855.3d0d281422f094677417c66b@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I try to connect my bluetooth headset.

Firstly, I start the bluetooth daemon:
$ sudo /usr/libexec/bluetooth/bluetoothd

Why I run bluetoothd with sudo?
Because otherwise, it fails:
$ /usr/libexec/bluetooth/bluetoothd 
D-Bus setup failed: Connection ":1.175" is not allowed to own the service "org.bluez" due to security policies in the configuration file

Secondly, I connect the bluetooth headset:
$ bluetoothctl 
[bluetooth]# 
spierre@desktop:~$ sudo bluetoothctl 
[NEW] Controller 00:60:57:33:62:AE BlueZ 5.37 [default]
[NEW] Device 00:22:37:34:9A:56 Philips SHB9150BK
[bluetooth]# power on
[CHG] Controller 00:60:57:33:62:AE Class: 0x000104
Changing power on succeeded
[CHG] Controller 00:60:57:33:62:AE Powered: yes
[bluetooth]# agent on
Agent registered
[bluetooth]# pair 00:22:37:34:9A:56
Attempting to pair with 00:22:37:34:9A:56
Failed to pair: org.bluez.Error.AlreadyExists
[bluetooth]# connect 00:22:37:34:9A:56
Attempting to connect to 00:22:37:34:9A:56
Failed to connect: org.bluez.Error.Failed

Why I run bluetoothctl with sudo?
Because otherwise, it hangs then I need to do Ctrl+C:
$ bluetoothctl 
[bluetooth]#

Why there is a failure please?
Do you think that the "native headsets" option should be set to "yes" instead of "no" in my pulseaudio-8.0 configuration*?

Thank you.
Best regards.

I am using on Slackware 14.1:
- bluez-5.37 (configured with the following options: --prefix=/usr --disable-systemd)
- pulseaudio-8.0* (configured with the following options: --prefix=/usr --sysconfdir=/etc --enable-bluez5)
- sbc-1.3 (configured with the following options: --prefix=/usr)
- alsa-lib-1.1.0 (configured with the following options: --prefix=/usr)
- alsa-oss-1.0.28 (configured with the following options: --prefix=/usr)
- alsa-plugins-1.1.0 (configured with the following options: --prefix=/usr)
- alsa-utils-1.1.0 (configured with the following options: --prefix=/usr)

* details for the pulseaudio-8.0 configuration:
 ---{ pulseaudio 8.0 }---

    prefix:                        /usr
    sysconfdir:                    /etc
    localstatedir:                 ${prefix}/var
    modlibexecdir:                 ${exec_prefix}/lib/pulse-8.0/modules
    System Runtime Path:           /usr/var/run/pulse
    System State Path:             /usr/var/lib/pulse
    System Config Path:            /usr/var/lib/pulse
    Zsh completions directory:     ${datarootdir}/zsh/site-functions
    Bash completions directory:    ${datarootdir}/bash-completion/completions
    Compiler:                      gcc -std=gnu99
    CFLAGS:                        -g -O2 -Wall -W -Wextra -pipe -Wno-long-long -Wno-overlength-strings -Wunsafe-loop-optimizations -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wcast-align -Wstrict-aliasing -Wwrite-strings -Wno-unused-parameter -ffast-math -fno-common -fdiagnostics-show-option
    CPPFLAGS:                      -DFASTPATH -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
    LIBS:                          -lgdbm -lcap -lpthread -lrt -ldl -lm 

    Enable X11:                    yes
    Enable OSS Output:             yes
    Enable OSS Wrapper:            yes
    Enable EsounD:                 yes
    Enable Alsa:                   yes
    Enable CoreAudio:              no
    Enable Solaris:                no
    Enable WaveOut:                no
    Enable GLib 2.0:               yes
    Enable Gtk+ 3.0:               yes
    Enable GConf:                  yes
    Enable Avahi:                  no
    Enable Jack:                   no
    Enable Async DNS:              no
    Enable LIRC:                   no
    Enable Xen PV driver:          no
    Enable D-Bus:                  yes
      Enable BlueZ 4:              yes
      Enable BlueZ 5:              yes
        Enable ofono headsets:     yes
        Enable native headsets:    no
    Enable udev:                   yes
      Enable HAL->udev compat:     yes
    Enable systemd
      Daemon (Socket Activation):  no
      Login (Session Tracking):    no
      Journal (Logging):           no
    Enable TCP Wrappers:           no
    Enable libsamplerate:          no
    Enable IPv6:                   yes
    Enable OpenSSL (for Airtunes): yes
    Enable fftw:                   yes
    Enable orc:                    yes
    Enable Adrian echo canceller:  yes
    Enable speex (resampler, AEC): yes
    Enable soxr (resampler):       yes
    Enable WebRTC echo canceller:  no
    Enable gcov coverage:          no
    Enable unit tests:             no
    Database
      tdb:                         no
      gdbm:                        yes
      simple database:             no

    System User:                   pulse
    System Group:                  pulse
    Access Group:                  pulse-access
    Enable per-user EsounD socket: yes
    Force preopen:                 no
    Preopened modules:             all

    Legacy Database Entry Support: yes
