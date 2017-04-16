Return-Path: <fengguang.wu@intel.com>
Date: Mon, 17 Apr 2017 06:12:16 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Harry Morris <harrymorris12@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [bluetooth-next:master 25/60]
 drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has
 incomplete type
Message-ID: <201704170609.9D6RVQ08%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
List-ID: <linux-bluetooth.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   297c3fb207ef8bc97daa144fb41c1fa9560f6965
commit: ded845a781a578dfb0b5b2c138e5a067aa3b1242 [25/60] ieee802154: Add CA8210 IEEE 802.15.4 device driver
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ded845a781a578dfb0b5b2c138e5a067aa3b1242
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
     struct clocksource clksrc;
                        ^~~~~~
>> drivers/clocksource/timer-sun5i.c:60:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/timer-sun5i.c:13:
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_oneshot':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clksrc_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'cs')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clksrc':
>> drivers/clocksource/timer-sun5i.c:171:3: error: implicit declaration of function 'clocksource_unregister' [-Werror=implicit-function-declaration]
      clocksource_unregister(&cs->clksrc);
      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:175:3: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
      clocksource_register_hz(&cs->clksrc, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clocksource':
>> drivers/clocksource/timer-sun5i.c:223:20: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cs->clksrc.mask = CLOCKSOURCE_MASK(32);
                       ^~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:224:21: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:224:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clkevt':
>> drivers/clocksource/timer-sun5i.c:251:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ce->clkevt, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clockevent':
>> drivers/clocksource/timer-sun5i.c:291:24: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                           ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:291:50: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:305:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ce->clkevt, rate,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: At top level:
>> drivers/clocksource/timer-sun5i.c:361:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:363:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:326:19: warning: 'sun5i_timer_init' defined but not used [-Wunused-function]
    static int __init sun5i_timer_init(struct device_node *node)
                      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/clocksource/cadence_ttc_timer.c:92:21: error: field 'cs' has incomplete type
     struct clocksource cs;
                        ^~
>> drivers/clocksource/cadence_ttc_timer.c:100:28: error: field 'ce' has incomplete type
     struct clock_event_device ce;
                               ^~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/cadence_ttc_timer.c:18:
   drivers/clocksource/cadence_ttc_timer.c: In function '__ttc_clocksource_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'timer')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_resume':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clocksource':
>> drivers/clocksource/cadence_ttc_timer.c:358:19: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
                      ^~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:359:20: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:359:20: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clocksource/cadence_ttc_timer.c:372:8: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
     err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_rate_change_clockevent_cb':
>> drivers/clocksource/cadence_ttc_timer.c:398:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clockevent':
>> drivers/clocksource/cadence_ttc_timer.c:441:23: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:441:49: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:468:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ttcce->ce,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: At top level:
>> drivers/clocksource/cadence_ttc_timer.c:542:29: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
                                ^~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:480:19: warning: 'ttc_timer_init' defined but not used [-Wunused-function]
    static int __init ttc_timer_init(struct device_node *timer)
                      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers//clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
     struct clocksource clksrc;
                        ^~~~~~
   drivers//clocksource/timer-sun5i.c:60:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers//clocksource/timer-sun5i.c:13:
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_oneshot':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clksrc_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'cs')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clksrc':
   drivers//clocksource/timer-sun5i.c:171:3: error: implicit declaration of function 'clocksource_unregister' [-Werror=implicit-function-declaration]
      clocksource_unregister(&cs->clksrc);
      ^~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:175:3: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
      clocksource_register_hz(&cs->clksrc, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_setup_clocksource':
   drivers//clocksource/timer-sun5i.c:223:20: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cs->clksrc.mask = CLOCKSOURCE_MASK(32);
                       ^~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:224:21: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:224:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clkevt':
   drivers//clocksource/timer-sun5i.c:251:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ce->clkevt, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_setup_clockevent':
   drivers//clocksource/timer-sun5i.c:291:24: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:291:50: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:305:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ce->clkevt, rate,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: At top level:
   drivers//clocksource/timer-sun5i.c:361:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:363:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:326:19: warning: 'sun5i_timer_init' defined but not used [-Wunused-function]
    static int __init sun5i_timer_init(struct device_node *node)
                      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..

vim +/clksrc +52 drivers/clocksource/timer-sun5i.c

4a59058f Maxime Ripard   2015-03-31   46  
3071efa4 Maxime Ripard   2015-03-31   47  #define to_sun5i_timer(x) \
3071efa4 Maxime Ripard   2015-03-31   48  	container_of(x, struct sun5i_timer, clk_rate_cb)
3071efa4 Maxime Ripard   2015-03-31   49  
4a59058f Maxime Ripard   2015-03-31   50  struct sun5i_timer_clksrc {
4a59058f Maxime Ripard   2015-03-31   51  	struct sun5i_timer	timer;
4a59058f Maxime Ripard   2015-03-31  @52  	struct clocksource	clksrc;
4a59058f Maxime Ripard   2015-03-31   53  };
4a59058f Maxime Ripard   2015-03-31   54  
4a59058f Maxime Ripard   2015-03-31   55  #define to_sun5i_timer_clksrc(x) \
4a59058f Maxime Ripard   2015-03-31  @56  	container_of(x, struct sun5i_timer_clksrc, clksrc)
4a59058f Maxime Ripard   2015-03-31   57  
4a59058f Maxime Ripard   2015-03-31   58  struct sun5i_timer_clkevt {
4a59058f Maxime Ripard   2015-03-31   59  	struct sun5i_timer		timer;
4a59058f Maxime Ripard   2015-03-31  @60  	struct clock_event_device	clkevt;
4a59058f Maxime Ripard   2015-03-31   61  };
4a59058f Maxime Ripard   2015-03-31   62  
4a59058f Maxime Ripard   2015-03-31   63  #define to_sun5i_timer_clkevt(x) \
4a59058f Maxime Ripard   2015-03-31   64  	container_of(x, struct sun5i_timer_clkevt, clkevt)
67905540 Maxime Ripard   2013-11-07   65  
67905540 Maxime Ripard   2013-11-07   66  /*
67905540 Maxime Ripard   2013-11-07   67   * When we disable a timer, we need to wait at least for 2 cycles of
67905540 Maxime Ripard   2013-11-07   68   * the timer source clock. We will use for that the clocksource timer
67905540 Maxime Ripard   2013-11-07   69   * that is already setup and runs at the same frequency than the other
67905540 Maxime Ripard   2013-11-07   70   * timers, and we never will be disabled.
67905540 Maxime Ripard   2013-11-07   71   */
4a59058f Maxime Ripard   2015-03-31   72  static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
67905540 Maxime Ripard   2013-11-07   73  {
4a59058f Maxime Ripard   2015-03-31   74  	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
67905540 Maxime Ripard   2013-11-07   75  
4a59058f Maxime Ripard   2015-03-31   76  	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
67905540 Maxime Ripard   2013-11-07   77  		cpu_relax();
67905540 Maxime Ripard   2013-11-07   78  }
67905540 Maxime Ripard   2013-11-07   79  
4a59058f Maxime Ripard   2015-03-31   80  static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
67905540 Maxime Ripard   2013-11-07   81  {
4a59058f Maxime Ripard   2015-03-31   82  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
4a59058f Maxime Ripard   2015-03-31   83  	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   84  
4a59058f Maxime Ripard   2015-03-31   85  	sun5i_clkevt_sync(ce);
67905540 Maxime Ripard   2013-11-07   86  }
67905540 Maxime Ripard   2013-11-07   87  
4a59058f Maxime Ripard   2015-03-31   88  static void sun5i_clkevt_time_setup(struct sun5i_timer_clkevt *ce, u8 timer, u32 delay)
67905540 Maxime Ripard   2013-11-07   89  {
4a59058f Maxime Ripard   2015-03-31   90  	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
67905540 Maxime Ripard   2013-11-07   91  }
67905540 Maxime Ripard   2013-11-07   92  
4a59058f Maxime Ripard   2015-03-31   93  static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, bool periodic)
67905540 Maxime Ripard   2013-11-07   94  {
4a59058f Maxime Ripard   2015-03-31   95  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   96  
67905540 Maxime Ripard   2013-11-07   97  	if (periodic)
67905540 Maxime Ripard   2013-11-07   98  		val &= ~TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07   99  	else
67905540 Maxime Ripard   2013-11-07  100  		val |= TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07  101  
67905540 Maxime Ripard   2013-11-07  102  	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  103  	       ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07  104  }
67905540 Maxime Ripard   2013-11-07  105  
7486f5ad Viresh Kumar    2015-06-18  106  static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  107  {
4a59058f Maxime Ripard   2015-03-31  108  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  109  
4a59058f Maxime Ripard   2015-03-31  110  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  111  	return 0;
7486f5ad Viresh Kumar    2015-06-18  112  }
7486f5ad Viresh Kumar    2015-06-18  113  
7486f5ad Viresh Kumar    2015-06-18  114  static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  115  {
7486f5ad Viresh Kumar    2015-06-18  116  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  117  
4a59058f Maxime Ripard   2015-03-31  118  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  119  	sun5i_clkevt_time_start(ce, 0, false);
7486f5ad Viresh Kumar    2015-06-18  120  	return 0;
67905540 Maxime Ripard   2013-11-07  121  }
7486f5ad Viresh Kumar    2015-06-18  122  
7486f5ad Viresh Kumar    2015-06-18  123  static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  124  {
7486f5ad Viresh Kumar    2015-06-18  125  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  126  
7486f5ad Viresh Kumar    2015-06-18  127  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  128  	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
7486f5ad Viresh Kumar    2015-06-18  129  	sun5i_clkevt_time_start(ce, 0, true);
7486f5ad Viresh Kumar    2015-06-18  130  	return 0;
67905540 Maxime Ripard   2013-11-07  131  }
67905540 Maxime Ripard   2013-11-07  132  
67905540 Maxime Ripard   2013-11-07  133  static int sun5i_clkevt_next_event(unsigned long evt,
4a59058f Maxime Ripard   2015-03-31  134  				   struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  135  {
4a59058f Maxime Ripard   2015-03-31  136  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  137  
4a59058f Maxime Ripard   2015-03-31  138  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  139  	sun5i_clkevt_time_setup(ce, 0, evt - TIMER_SYNC_TICKS);
4a59058f Maxime Ripard   2015-03-31  140  	sun5i_clkevt_time_start(ce, 0, false);
67905540 Maxime Ripard   2013-11-07  141  
67905540 Maxime Ripard   2013-11-07  142  	return 0;
67905540 Maxime Ripard   2013-11-07  143  }
67905540 Maxime Ripard   2013-11-07  144  
67905540 Maxime Ripard   2013-11-07  145  static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
67905540 Maxime Ripard   2013-11-07  146  {
4a59058f Maxime Ripard   2015-03-31  147  	struct sun5i_timer_clkevt *ce = (struct sun5i_timer_clkevt *)dev_id;
67905540 Maxime Ripard   2013-11-07  148  
4a59058f Maxime Ripard   2015-03-31  149  	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
4a59058f Maxime Ripard   2015-03-31  150  	ce->clkevt.event_handler(&ce->clkevt);
67905540 Maxime Ripard   2013-11-07  151  
67905540 Maxime Ripard   2013-11-07  152  	return IRQ_HANDLED;
67905540 Maxime Ripard   2013-11-07  153  }
67905540 Maxime Ripard   2013-11-07  154  
a5a1d1c2 Thomas Gleixner 2016-12-21  155  static u64 sun5i_clksrc_read(struct clocksource *clksrc)
59387683 Chen-Yu Tsai    2016-10-18  156  {
59387683 Chen-Yu Tsai    2016-10-18 @157  	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
59387683 Chen-Yu Tsai    2016-10-18  158  
59387683 Chen-Yu Tsai    2016-10-18  159  	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
59387683 Chen-Yu Tsai    2016-10-18  160  }
59387683 Chen-Yu Tsai    2016-10-18  161  
3071efa4 Maxime Ripard   2015-03-31  162  static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  163  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  164  {
3071efa4 Maxime Ripard   2015-03-31  165  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  166  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  167  	struct sun5i_timer_clksrc *cs = container_of(timer, struct sun5i_timer_clksrc, timer);
3071efa4 Maxime Ripard   2015-03-31  168  
3071efa4 Maxime Ripard   2015-03-31  169  	switch (event) {
3071efa4 Maxime Ripard   2015-03-31  170  	case PRE_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @171  		clocksource_unregister(&cs->clksrc);
3071efa4 Maxime Ripard   2015-03-31  172  		break;
3071efa4 Maxime Ripard   2015-03-31  173  
3071efa4 Maxime Ripard   2015-03-31  174  	case POST_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @175  		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  176  		break;
3071efa4 Maxime Ripard   2015-03-31  177  
3071efa4 Maxime Ripard   2015-03-31  178  	default:
3071efa4 Maxime Ripard   2015-03-31  179  		break;
3071efa4 Maxime Ripard   2015-03-31  180  	}
3071efa4 Maxime Ripard   2015-03-31  181  
3071efa4 Maxime Ripard   2015-03-31  182  	return NOTIFY_DONE;
3071efa4 Maxime Ripard   2015-03-31  183  }
3071efa4 Maxime Ripard   2015-03-31  184  
4a59058f Maxime Ripard   2015-03-31  185  static int __init sun5i_setup_clocksource(struct device_node *node,
4a59058f Maxime Ripard   2015-03-31  186  					  void __iomem *base,
4a59058f Maxime Ripard   2015-03-31  187  					  struct clk *clk, int irq)
4a59058f Maxime Ripard   2015-03-31  188  {
4a59058f Maxime Ripard   2015-03-31  189  	struct sun5i_timer_clksrc *cs;
4a59058f Maxime Ripard   2015-03-31  190  	unsigned long rate;
4a59058f Maxime Ripard   2015-03-31  191  	int ret;
4a59058f Maxime Ripard   2015-03-31  192  
4a59058f Maxime Ripard   2015-03-31  193  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
4a59058f Maxime Ripard   2015-03-31  194  	if (!cs)
4a59058f Maxime Ripard   2015-03-31  195  		return -ENOMEM;
4a59058f Maxime Ripard   2015-03-31  196  
4a59058f Maxime Ripard   2015-03-31  197  	ret = clk_prepare_enable(clk);
4a59058f Maxime Ripard   2015-03-31  198  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  199  		pr_err("Couldn't enable parent clock\n");
4a59058f Maxime Ripard   2015-03-31  200  		goto err_free;
4a59058f Maxime Ripard   2015-03-31  201  	}
4a59058f Maxime Ripard   2015-03-31  202  
4a59058f Maxime Ripard   2015-03-31  203  	rate = clk_get_rate(clk);
4a59058f Maxime Ripard   2015-03-31  204  
4a59058f Maxime Ripard   2015-03-31  205  	cs->timer.base = base;
4a59058f Maxime Ripard   2015-03-31  206  	cs->timer.clk = clk;
3071efa4 Maxime Ripard   2015-03-31  207  	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
3071efa4 Maxime Ripard   2015-03-31  208  	cs->timer.clk_rate_cb.next = NULL;
3071efa4 Maxime Ripard   2015-03-31  209  
3071efa4 Maxime Ripard   2015-03-31  210  	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
3071efa4 Maxime Ripard   2015-03-31  211  	if (ret) {
3071efa4 Maxime Ripard   2015-03-31  212  		pr_err("Unable to register clock notifier.\n");
3071efa4 Maxime Ripard   2015-03-31  213  		goto err_disable_clk;
3071efa4 Maxime Ripard   2015-03-31  214  	}
4a59058f Maxime Ripard   2015-03-31  215  
4a59058f Maxime Ripard   2015-03-31  216  	writel(~0, base + TIMER_INTVAL_LO_REG(1));
4a59058f Maxime Ripard   2015-03-31  217  	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  218  	       base + TIMER_CTL_REG(1));
4a59058f Maxime Ripard   2015-03-31  219  
59387683 Chen-Yu Tsai    2016-10-18  220  	cs->clksrc.name = node->name;
59387683 Chen-Yu Tsai    2016-10-18  221  	cs->clksrc.rating = 340;
59387683 Chen-Yu Tsai    2016-10-18  222  	cs->clksrc.read = sun5i_clksrc_read;
59387683 Chen-Yu Tsai    2016-10-18 @223  	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
59387683 Chen-Yu Tsai    2016-10-18 @224  	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
59387683 Chen-Yu Tsai    2016-10-18  225  
59387683 Chen-Yu Tsai    2016-10-18  226  	ret = clocksource_register_hz(&cs->clksrc, rate);
4a59058f Maxime Ripard   2015-03-31  227  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  228  		pr_err("Couldn't register clock source.\n");
3071efa4 Maxime Ripard   2015-03-31  229  		goto err_remove_notifier;
4a59058f Maxime Ripard   2015-03-31  230  	}
4a59058f Maxime Ripard   2015-03-31  231  
4a59058f Maxime Ripard   2015-03-31  232  	return 0;
4a59058f Maxime Ripard   2015-03-31  233  
3071efa4 Maxime Ripard   2015-03-31  234  err_remove_notifier:
3071efa4 Maxime Ripard   2015-03-31  235  	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
4a59058f Maxime Ripard   2015-03-31  236  err_disable_clk:
4a59058f Maxime Ripard   2015-03-31  237  	clk_disable_unprepare(clk);
4a59058f Maxime Ripard   2015-03-31  238  err_free:
4a59058f Maxime Ripard   2015-03-31  239  	kfree(cs);
4a59058f Maxime Ripard   2015-03-31  240  	return ret;
4a59058f Maxime Ripard   2015-03-31  241  }
4a59058f Maxime Ripard   2015-03-31  242  
3071efa4 Maxime Ripard   2015-03-31  243  static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  244  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  245  {
3071efa4 Maxime Ripard   2015-03-31  246  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  247  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  248  	struct sun5i_timer_clkevt *ce = container_of(timer, struct sun5i_timer_clkevt, timer);
3071efa4 Maxime Ripard   2015-03-31  249  
3071efa4 Maxime Ripard   2015-03-31  250  	if (event == POST_RATE_CHANGE) {
3071efa4 Maxime Ripard   2015-03-31 @251  		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  252  		ce->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
3071efa4 Maxime Ripard   2015-03-31  253  	}
3071efa4 Maxime Ripard   2015-03-31  254  

:::::: The code at line 52 was first introduced by commit
:::::: 4a59058f0b09682200c04b1db236b4a3b92128d7 clocksource/drivers/sun5i: Refactor the current code

:::::: TO: Maxime Ripard <maxime.ripard@free-electrons.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--OgqxwSJOaUobr8KG
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OgqxwSJOaUobr8KG--
