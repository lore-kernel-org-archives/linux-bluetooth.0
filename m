Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b050628033668da137c@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Compile btsco kernel module on FC4
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
Date: Tue, 28 Jun 2005 11:36:48 +0100

Hi All,

Anyone had any luck compling the btsco kernel module on FC4. When I
tried I get the following spew (and that's only a small bit of it).

Cheers,
Pete

/home/peterr/download/build/btsco/kernel/btsco.c:98: error: syntax
error before 'atomic_t'
/home/peterr/download/build/btsco/kernel/btsco.c:98: warning: no
semicolon at end of struct or union
/home/peterr/download/build/btsco/kernel/btsco.c:120: error: syntax
error before '}' token
/home/peterr/download/build/btsco/kernel/btsco.c:120: warning: type
defaults to 'int' in declaration of 'snd_card_bt_sco_t'
/home/peterr/download/build/btsco/kernel/btsco.c:120: warning: data
definition has no type or storage class
/home/peterr/download/build/btsco/kernel/btsco.c:123: error: syntax
error before 'snd_card_bt_sco_t'
/home/peterr/download/build/btsco/kernel/btsco.c:123: warning: no
semicolon at end of struct or union
/home/peterr/download/build/btsco/kernel/btsco.c:131: error: syntax
error before '}' token
/home/peterr/download/build/btsco/kernel/btsco.c:131: warning: type
defaults to 'int' in declaration of 'snd_card_bt_sco_pcm_t'
/home/peterr/download/build/btsco/kernel/btsco.c:131: warning: data
definition has no type or storage class
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_playback_trigger':
/home/peterr/download/build/btsco/kernel/btsco.c:138: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:139: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:139: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:140: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:140: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:151: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_capture_trigger':
/home/peterr/download/build/btsco/kernel/btsco.c:159: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:160: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:160: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:161: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:161: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:172: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_pcm_prepare':
/home/peterr/download/build/btsco/kernel/btsco.c:179: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:180: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:180: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:181: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:183: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:183: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:184: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:187: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:209: error: syntax
error before '*' token
/home/peterr/download/build/btsco/kernel/btsco.c:211: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_pcm_receive':
/home/peterr/download/build/btsco/kernel/btsco.c:215: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:241: error: syntax
error before '*' token
/home/peterr/download/build/btsco/kernel/btsco.c:243: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_pcm_send':
/home/peterr/download/build/btsco/kernel/btsco.c:247: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_playback_pointer':
/home/peterr/download/build/btsco/kernel/btsco.c:275: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:276: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:276: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_capture_pointer':
/home/peterr/download/build/btsco/kernel/btsco.c:284: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:285: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:285: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:290: error: syntax
error before 'snd_card_bt_sco_playback'
/home/peterr/download/build/btsco/kernel/btsco.c:290: warning: type
defaults to 'int' in declaration of 'snd_card_bt_sco_playback'
/home/peterr/download/build/btsco/kernel/btsco.c:291: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:291: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:293: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:293: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:293: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:293: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:294: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:294: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:294: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:294: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:295: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:295: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:295: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:295: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:296: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:296: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:296: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:296: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:297: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:297: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:297: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:297: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:298: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:298: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:298: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:298: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:299: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:299: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:299: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:299: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:300: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:300: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:300: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:300: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:301: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:301: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:301: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:301: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:302: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:302: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:302: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:302: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:303: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:303: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:303: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:303: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:304: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:304: error: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:304: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:304: warning: (near
initialization for 'snd_card_bt_sco_playback')
/home/peterr/download/build/btsco/kernel/btsco.c:305: warning: data
definition has no type or storage class
/home/peterr/download/build/btsco/kernel/btsco.c:307: error: syntax
error before 'snd_card_bt_sco_capture'
/home/peterr/download/build/btsco/kernel/btsco.c:307: warning: type
defaults to 'int' in declaration of 'snd_card_bt_sco_capture'
/home/peterr/download/build/btsco/kernel/btsco.c:308: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:308: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:310: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:310: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:310: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:310: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:311: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:311: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:311: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:311: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:312: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:312: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:312: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:312: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:313: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:313: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:313: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:313: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:314: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:314: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:314: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:314: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:315: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:315: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:315: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:315: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:316: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:316: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:316: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:316: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:317: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:317: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:317: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:317: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:318: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:318: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:318: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:318: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:319: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:319: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:319: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:319: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:320: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:320: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:320: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:320: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:321: error: field
name not in record or union initializer
/home/peterr/download/build/btsco/kernel/btsco.c:321: error: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:321: warning: excess
elements in scalar initializer
/home/peterr/download/build/btsco/kernel/btsco.c:321: warning: (near
initialization for 'snd_card_bt_sco_capture')
/home/peterr/download/build/btsco/kernel/btsco.c:322: warning: data
definition has no type or storage class
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_runtime_free':
/home/peterr/download/build/btsco/kernel/btsco.c:326: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:326: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_playback_open':
/home/peterr/download/build/btsco/kernel/btsco.c:332: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:333: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:334: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:334: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:340: error: 'ENOMEM'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:342: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:347: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:350: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:351: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:352: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_capture_open':
/home/peterr/download/build/btsco/kernel/btsco.c:365: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:366: error: 'bspcm'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:367: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:367: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:373: error: 'ENOMEM'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:375: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:380: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:381: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:381: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:384: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:385: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:386: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_playback_close':
/home/peterr/download/build/btsco/kernel/btsco.c:399: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:400: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:400: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:415: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:415: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_capture_close':
/home/peterr/download/build/btsco/kernel/btsco.c:421: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:423: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:425: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:429: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:430: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:432: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:433: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:434: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:435: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:436: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:438: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:438: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:460: error: syntax
error before '*' token
/home/peterr/download/build/btsco/kernel/btsco.c:461: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_pcm':
/home/peterr/download/build/btsco/kernel/btsco.c:466: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_volume_info':
/home/peterr/download/build/btsco/kernel/btsco.c:487: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:488: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:489: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:490: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_volume_get':
/home/peterr/download/build/btsco/kernel/btsco.c:497: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:497: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:498: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:499: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_volume_put':
/home/peterr/download/build/btsco/kernel/btsco.c:510: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:510: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:511: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:512: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_boolean_info':
/home/peterr/download/build/btsco/kernel/btsco.c:536: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:537: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:538: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:539: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_loopback_get':
/home/peterr/download/build/btsco/kernel/btsco.c:546: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:546: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:547: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_bt_sco_loopback_put':
/home/peterr/download/build/btsco/kernel/btsco.c:558: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:558: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:559: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:586: error: syntax
error before '*' token
/home/peterr/download/build/btsco/kernel/btsco.c:587: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_new_mixer':
/home/peterr/download/build/btsco/kernel/btsco.c:588: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_ioctl':
/home/peterr/download/build/btsco/kernel/btsco.c:620: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:621: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:622: error: 'ENOTTY'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:626: error: syntax
error before 'int'
/home/peterr/download/build/btsco/kernel/btsco.c:631: error: 'SIGINT'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:642: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:645: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:646: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:651: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:651: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:661: error: case
label does not reduce to an integer constant
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:672: error: syntax
error before 'loff_t'
/home/peterr/download/build/btsco/kernel/btsco.c:673: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_write':
/home/peterr/download/build/btsco/kernel/btsco.c:674: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:674: error: invalid
type argument of '->'
/home/peterr/download/build/btsco/kernel/btsco.c:675: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:680: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:682: error: 'buf'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:683: error: 'EFAULT'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: At top level:
/home/peterr/download/build/btsco/kernel/btsco.c:707: error: syntax
error before 'loff_t'
/home/peterr/download/build/btsco/kernel/btsco.c:708: warning:
function declaration isn't a prototype
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_read':
/home/peterr/download/build/btsco/kernel/btsco.c:709: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:709: error: invalid
type argument of '->'
/home/peterr/download/build/btsco/kernel/btsco.c:710: error: 'current'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:710: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:711: error: syntax
error before 'retval'
/home/peterr/download/build/btsco/kernel/btsco.c:716: error: 'EINVAL'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:738: error: 'retval'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:749: error: 'buf'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:750: error: 'EFAULT'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:758: warning: control
reaches end of non-void function
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_poll':
/home/peterr/download/build/btsco/kernel/btsco.c:763: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:764: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:771: error: 'POLLIN'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:771: error:
'POLLRDNORM' undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_thread':
/home/peterr/download/build/btsco/kernel/btsco.c:785: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:786: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:790: error: storage
size of 'msg' isn't known
/home/peterr/download/build/btsco/kernel/btsco.c:791: error: storage
size of 'iov' isn't known
/home/peterr/download/build/btsco/kernel/btsco.c:792: error:
'sigset_t' undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:792: error: syntax
error before 'unblocked'
/home/peterr/download/build/btsco/kernel/btsco.c:797: error:
'unblocked' undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:798: error: 'SIGINT'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:799: error: 'SIGTERM'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:800: error:
'SIG_UNBLOCK' undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:803: warning:
implicit declaration of function 'set_fs'
/home/peterr/download/build/btsco/kernel/btsco.c:803: error:
'KERNEL_DS' undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:809: error: 'current'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:825: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:924: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:925: error:
dereferencing pointer to incomplete type
/home/peterr/download/build/btsco/kernel/btsco.c:791: warning: unused
variable 'iov'
/home/peterr/download/build/btsco/kernel/btsco.c:790: warning: unused
variable 'msg'
/home/peterr/download/build/btsco/kernel/btsco.c:937: warning: control
reaches end of non-void function
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_private_free':
/home/peterr/download/build/btsco/kernel/btsco.c:941: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:945: error: 'SIGTERM'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'snd_card_bt_sco_probe':
/home/peterr/download/build/btsco/kernel/btsco.c:962: error: 'bt_sco'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:963: warning: ISO C90
forbids mixed declarations and code
/home/peterr/download/build/btsco/kernel/btsco.c:970: error: 'ENOMEM'
undeclared (first use in this function)
/home/peterr/download/build/btsco/kernel/btsco.c:982: warning:
implicit declaration of function 'init_MUTEX_LOCKED'
/home/peterr/download/build/btsco/kernel/btsco.c:983: warning:
implicit declaration of function 'init_MUTEX'
/home/peterr/download/build/btsco/kernel/btsco.c:994: warning:
implicit declaration of function 'kernel_thread'
/home/peterr/download/build/btsco/kernel/btsco.c: In function
'alsa_card_bt_sco_init':
/home/peterr/download/build/btsco/kernel/btsco.c:1041: error: 'ENODEV'
undeclared (first use in this function)
make[2]: *** [/home/peterr/download/build/btsco/kernel/btsco.o] Error 1
make[1]: *** [_module_/home/peterr/download/build/btsco/kernel] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.11-1.1369_FC4-i686'
make: *** [default] Error 2


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
